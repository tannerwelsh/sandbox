require_relative 'lib/pneumatic'

# if ARGV.any?
#   Pneumatic::CLI.from_argv(ARGV).run
# end

Pneumatic::Server.new.start