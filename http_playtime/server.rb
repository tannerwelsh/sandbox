require 'socket'
require 'erb'

header = <<-HEADER
HTTP/1.1 200 OK
Date: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")}
Server: Ruby Simple Server
Last-Modified: #{Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")}
Accept-Ranges: bytes
Connection: close
Content-Type: text/html
HEADER

output = ""
source = File.read('./template.html.erb')

erb = ERB.new(source, 0, '', :output).result binding

server = TCPServer.new('localhost', 3456)

loop do
  puts "waiting for request...."
  client = server.accept
  puts "connected to #{client}"

  request = ""
  content_length = 0

  client.each do |input|
    request += input.to_s

    if request =~ /\AGET/
      break if input.nil? || input.chomp.empty?
    elsif request =~ /\APOST/
      if input =~ /Content-Length:\s(\d*)/
        content_length = input.match(/Content-Length:\s(\d*)/)[1].to_i
      end
      
      break if input =~ /^\s{2}$/
    end
  end

  if request =~ /\APOST/ && content_length > 0
    body = client.read(content_length)
  end

  puts "REQUEST DETAILS:"
  puts request
  puts body if body

  puts "END OF REQUEST"
  puts "*" * 30

  client.write header
  client.write "\n"
  client.write output
  client.close
end