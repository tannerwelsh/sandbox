require "midi"

# prompt the user to select an input and output

@input = UniMIDI::Input.gets
@output = UniMIDI::Output.gets

MIDI.using(@output) do

  5.times do |oct|
    octave oct
    %w{C E G B}.each { |n| play n, 0.5 }
  end

end