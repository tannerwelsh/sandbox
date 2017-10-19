require_relative './pigden_cipher'

# ('a'..'z').each do |letter|
#   PigdenCipher::Character.new(letter).save
# end

PigdenCipher::Phrase.new('hi there, stop.').save
