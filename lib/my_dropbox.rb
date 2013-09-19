require 'dropbox_sdk'
require 'front_matter'
require 'redcarpet'
require_relative 'db'

# You must use your Dropbox App key and secret to use the API.
# Find this at https://www.dropbox.com/developers

class MyDropbox
  def initialize
    @db = DB.new
  end

  def login
    if not @client.nil?
      puts "already logged in!"
    else
      access_token = @db.read("dropbox", "access_token")

      if access_token.nil?
        app_key = ENV['APP_KEY']
        app_secret = ENV['APP_SECRET']
        web_auth = DropboxOAuth2FlowNoRedirect.new(app_key, app_secret)
        authorize_url = web_auth.start()
        puts "1. Go to: #{authorize_url}"
        puts "2. Click \"Allow\" (you might have to log in first)."
        puts "3. Copy the authorization code."

        print "Enter the authorization code here: "
        STDOUT.flush
        auth_code = STDIN.gets.strip

        access_token, user_id = web_auth.finish(auth_code)
        @db.update_access_token access_token
      end

      @client = DropboxClient.new(access_token)
      puts "You are logged in. Looking for things to post..."
    end
  end

  def logout
    @client = nil
    puts "You are logged out."
  end

  def check_changed_files
    cursor = @db.read("dropbox", "delta_cursor")

    delta = @client.delta(cursor)
    puts delta.inspect
    delta["entries"].each do |entry|
      if entry[1].nil?
        @db.remove_post entry[0]
      else
        parse_post entry[0]
      end
    end
    @db.update_cursor delta["cursor"]
  end

  def parse_post path
    markdown_opts = [:autolink => true, :space_after_headers => true]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *markdown_opts)

    out, metadata = @client.get_file_and_metadata path
    fm = FrontMatter.new(:unindent => true, :as_yaml => true)
    options = YAML.load fm.extract(out)[0]

    if options["draft"] == true
      @db.remove_post path
    else
      options["body"] = markdown.render(out.gsub(/# ---.*# ---\n*/m,""))
      options["filename"] = path
      @db.update_post options
      puts "Updated '#{options["title"]}'"
    end
  end
end