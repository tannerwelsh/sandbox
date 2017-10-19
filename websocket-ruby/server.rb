require 'em-websocket'
require 'debugger'

EM.run do 
  @channel = EM::Channel.new

  EM::WebSocket.run(host: 'localhost', port: 1234) do |ws|
    ws.onopen do
      sid = @channel.subscribe { |msg| ws.send msg }
      @channel.push "#{sid} connected!"

      ws.onmessage do |msg|
        puts "Received message: #{msg}"
        @channel.push "#{msg}"
      end

      ws.onclose do
        @channel.unsubscribe sid
      end
    end
  end

  puts 'Server started!'
end
