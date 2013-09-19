require 'sequel'
require 'pry'
require 'time'

class DB

  def initialize()
    raise "No Database specified." if ENV['DATABASE_URL'].nil?

    begin
      unless ENV['DATABASE_URL'].nil?
        @db = Sequel.connect ENV['DATABASE_URL']
      end
    rescue
      raise "Cannot connect to database."
    end
  end

  def close
    @db.close if @db
  end

  def update_post(opts = {})
    dataset = @db[:posts].where(:permalink => opts["permalink"])
    if dataset.first.nil?
      opts["created_at"] = opts["updated_at"] = Time.now
      dataset.insert(opts)
    else
      opts["updated_at"] = Time.now
      dataset.update(opts)
    end
  end

  def remove_post(filename)
    puts "Removing #{filename}"
    @db[:posts].where(:filename => filename).delete
  end

  def update_cursor(cursor)
    dataset = @db[:dropbox].where(:id => 1)
    if dataset.first.nil?
      dataset.insert({delta_cursor: cursor, created_at: Time.now, updated_at: Time.now})
    else
      dataset.update({delta_cursor: cursor, updated_at: Time.now})
    end
  end

  def update_access_token(token)
    dataset = @db[:dropbox].where(:id => 1)
    if dataset.first.nil?
      dataset.insert({id: 1, access_token: token, created_at: Time.now, updated_at: Time.now})
    else
      dataset.update({access_token: token, updated_at: Time.now})
    end
  end

  def read(table, column)
    dataset = @db[table.to_sym].where(:id => 1)
    dataset.first[column.to_sym] unless dataset.first.nil?
  end
end