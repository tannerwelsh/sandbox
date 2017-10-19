require 'unimidi'

input = UniMIDI::Input.first

input.open do |input|
  $stdout.puts "send some MIDI to your input now..."

  loop do
    m = input.gets
    $stdout.puts(m)
  end
end
