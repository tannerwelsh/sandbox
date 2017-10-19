require_relative 'lib/pneumatic'

Pneumatic::Client.new(handle: ARGV.join("_")).start