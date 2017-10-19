module PigdenCipher
  class Phrase
    CHAR_WIDTH = 16
    CHAR_HEIGHT = 16

    def initialize(phrase)
      @phrase = phrase
    end

    def pigden_chars
      @pigden_chars ||= @phrase.chars.map { |char| Character.new(char) }
    end

    def width
      pigden_chars.count * CHAR_WIDTH
    end

    def height
      CHAR_HEIGHT
    end

    def img
      img = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::WHITE)

      x_offset = 0

      pigden_chars.each do |char|
        img.compose!(char.img, x_offset)

        x_offset += CHAR_WIDTH
      end

      img
    end

    def save(filename = @phrase)
      img.save("phrases/#{filename}.png")
    end
  end
end
