require 'socket'

server = TCPServer.new 7890

loop do
  client = server.accept

  client.puts "I'm going to be very annoying."
  loop do
    message = client.gets.chomp
    client.puts message
  end
  client.close
end

