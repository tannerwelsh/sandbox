require 'timeout'

module Pneumatic
  class ClosedServerError < SocketError; end

  class Server
    include Timeout

    def initialize(opts = {})
      @hostname = opts.fetch(:hostname) { DEFAULTS[:hostname] }
      @port     = opts.fetch(:port)     { DEFAULTS[:port]     }
      @socket   = TCPServer.new(@hostname, @port)
      @clients  = []
      @logger   = $stdout#File.open(File.expand_path('../log.txt', __FILE__), 'a')
    end

    def start
      # @main_thread = Thread.new do
        loop do
          if client = accept_client
            @clients << client
            connections << respond_to_client(client)
          end
        end
      # end
      # loop do
      #   stop if Kernel.gets.chomp == 'quit'
      # end
    end

    def stop
      connections.each(&:kill)
      # main_thread && main_thread.kill
      @logger.puts("closed.")
      @logger.close
    end

    def respond_to_all(opts = {})
      message = opts.fetch(:message)
      from    = opts.fetch(:from)

      @clients.each { |client| client.puts(message) unless client == from }
      # @mutex.synchronize do
      #   @main_thread['clients'].each { |client| client.puts(message) }
      # end
    end

    def respond_to_client(client_connection)
      Thread.new(client_connection) do |client|
        @logger.puts("New connection with #{client}...")
        @logger.puts("Clients: #{@clients}")
        client.puts("Welcome! There are #{@clients.count} people online.")

        loop do
          # message = get_message(client)
          message = client.gets.chomp
          break if message == 'quit'
          if message
            @logger.puts("Message from #{client}: #{message}")
            respond_to_all(message: message, from: client)
          end
          # client.puts(response)
        end
      end
    end

    def get_message(client)
      begin
        timeout(1) { return client.gets }
      rescue
        return nil
      end
    end

    def can_connect?
      !!(socket)# && main_thread && main_thread.alive?)
    end

    def accept_client
      can_connect? ? socket.accept : raise(ClosedServerError, "The server is not accepting new connections.")
    end

    def connections
      @connections ||= []
    end

  private

    attr_reader :socket, :main_thread
  end
end
