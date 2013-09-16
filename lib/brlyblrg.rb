require_relative 'my_dropbox'
require 'time'
require 'clockwork'

include Clockwork

dropbox = MyDropbox.new
dropbox.login

handler do |job|
  dropbox.check_changed_files
end

every(5.minutes, 'check for blog updates')