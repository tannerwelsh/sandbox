require_relative '../lib/pneumatic'

require 'rspec'
require 'rspec/autorun'

module SocketHelper
  def self.is_open?(opts = {})
    begin
      socket = TCPSocket.new(opts[:hostname], opts[:port])
      socket.close
      true
    rescue
      false
    end
  end
end
