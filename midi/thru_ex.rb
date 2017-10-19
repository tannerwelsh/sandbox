require 'midi'

@input = UniMIDI::Input.first
@output = UniMIDI::Output.first

MIDI.using(@input, @output, $stdout) do

  note = listen

  play note, 1

end
