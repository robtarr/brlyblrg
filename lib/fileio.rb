require 'fileutils'

class FileIO

  def self.save data, path
    FileUtils.mkdir_p File.dirname(path)
    puts "Saving: #{path}"
    File.open(path, 'w') do |f|
      f.puts data
    end
  end

  def self.rm path
    begin
      puts "Removing #{path}"
      FileUtils.rm_rf path
    rescue Exception => e
      puts "Path: #{path}"
      puts e.message
      puts e.backtrace.inspect
    end
  end

end