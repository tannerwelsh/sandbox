Signal.trap('INT') do
  puts self
  exit
end

p Process.pid
sleep
