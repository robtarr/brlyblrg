require_relative 'brlyblrg'
require 'time'
require 'clockwork'

include Clockwork

brlyblrg = Brlyblrg.new

handler do |job|
  brlyblrg.process_files
end

every(5.minutes, 'check for blog updates')