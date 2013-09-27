require_relative 'my_dropbox'

class Brlyblrg

  def initialize
    @dropbox = MyDropbox.new
    @dropbox.login
    @db = DB.new
  end

  def process_files
    posts, assets = @dropbox.check_changed_files
    process_posts posts
    process_assets assets
  end

  def process_posts posts
    posts.each do |entry|
      if entry[1].nil?
        @db.remove_post entry[0]
      else
        parse_post entry[0]
      end
    end
  end

  def process_assets assets
    assets.each do |entry|
      path = "site#{entry[0]}"

      if entry[1].nil?
        FileIO.rm path
      else
        unless entry[1]["is_dir"]
          data = @dropbox.get_file(entry[0])
          FileIO.save data, path
        end
      end
    end
  end

  def parse_post path
    markdown_opts = [:autolink => true, :space_after_headers => true]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *markdown_opts)

    out, metadata = @dropbox.get_metadata path
    fm = FrontMatter.new(:unindent => true, :as_yaml => true)
    options = YAML.load fm.extract(out)[0]

    if options["status"] == "draft"
      @db.remove_post path
    else
      options["body"] = markdown.render(out.gsub(/# ---.*# ---\n*/m,""))
      options["filename"] = path
      options.delete "status"
      @db.update_post options
      puts "Updated '#{options["title"]}'"
    end
  end
end