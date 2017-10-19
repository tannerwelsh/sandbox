require 'timeout'
require 'rainbow'

module Pneumatic
  class Client
    include Timeout

    attr_reader :server, :handle

    def initialize(opts = {})
      @hostname = opts.fetch(:hostname) { DEFAULTS[:hostname] }
      @port     = opts.fetch(:port)     { DEFAULTS[:port] }
      @handle   = opts.fetch(:handle)   { 'anonymous' }
      @server   = TCPSocket.open(@hostname, @port)
    end

    def quiet_timeout(seconds)
      timeout(seconds) {
        yield
      }
    rescue
    end

    def get_username
      @handle = STDIN.gets.chomp
    end

    def start
      # get_username

      loop do
        response = nil

        quiet_timeout(1) {
          message = server.gets.chomp
          STDOUT.puts(message.color(:blue))
        }
        quiet_timeout(1) {
          response = STDIN.gets.chomp
          return if response =~ /(exit|quit)/
          server.puts("[#{@handle}] #{response}")
        }
      end
    end
  end
end