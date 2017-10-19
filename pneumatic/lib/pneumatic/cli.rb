module Pneumatic
  class CLI
    def initialize(command, args)
      @command, @args = command, args
    end

    def run
      case @command
      when 'server'
        # puts 'launching server...'
        s = Server.new
        s.start
      when 'client'
        c = Client.new
        c.start
      end
    end

    def self.from_argv(args)
      command = args.shift
      
      self.new(command, args)
    end
  end
end