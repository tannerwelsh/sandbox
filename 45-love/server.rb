require 'socket'

server = TCPServer.new 'localhost', '1234'

loop do
  serv_thread = Thread.start(server.accept) do |client|
    puts "Incoming request..."
    client.puts "Hello!"
    client.puts "Client:"
    client.puts client.inspect
    client.puts "Server:"
    client.puts server.inspect
    client.puts "Time: #{Time.now}"
    client.close
  end
end
