module PigdenCipher
  class Punctuation
    attr_reader :latin_char, :opts

    def initialize(latin_char, opts)
      @latin_char = latin_char
      @opts = opts
    end

    def img
      @img ||= draw
    end

    def draw
      img = ChunkyPNG::Image.new(opts[:width], opts[:height], ChunkyPNG::Color::WHITE)

      # TODO: this method knows too much
      return img if latin_char == ' '

      lines.each do |line_params|
        img.rect( *line_params )
      end

      img
    end

    def save(filename, opts = {})
      img.save(filename, opts)
    end

  private

    def lines
      width, height, color = opts[:width], opts[:height], opts[:color]

      case latin_char
      when '.'
        [
          [(width / 3), height - 3, (width / 3) + 1, height - 2, color, color]
        ]
      when ','
        [
          [(width / 3), height - 5, (width / 3) + 1, height - 2, color, color]
        ]
      end
    end
  end
end
