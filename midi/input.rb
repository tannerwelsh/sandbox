#!/usr/bin/env ruby

require "unimidi"
require 'midi-message'

input = UniMIDI::Input.first

# using their selection...

puts "send some MIDI to your input now..."

loop do
  m = input.gets.first

  next if [248, 254].include? m[:data].first.to_i # ignore connectivity messages

  data = m[:data]

  if data.last == 0
    msg = MIDIMessage::NoteOff.new(*data[0..1])
  else
    msg = MIDIMessage::NoteOn.new(*data[0..1])
  end

  puts "#{msg.note} : #{msg.name}"
end

puts "finished"
