module PigdenCipher
  class Angled
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

      lines.each do |line_params|
        img.line( *line_params )
      end

      format_appropriately(img)

      img
    end

    def save(filename, opts = {})
      img.save(filename, opts)
    end

  private

    def lines
      width, height, color = opts[:width], opts[:height], opts[:color]

      [
        [1, 1, width / 2, height - 2, color, color],
        [2, 1, width / 2, height - 3, color, color],
        [1, 2, width / 2 - 1, height - 2, color, color],
        [width - 2, 1, width / 2, height - 2, color, color],
        [width - 3, 1, width / 2, height - 3, color, color],
        [width - 2, 2, width / 2 + 1, height - 2, color, color]
      ]
    end

    def dot
      width, height, color = opts[:width], opts[:height], opts[:color]

      [(width / 2) - 1, (height / 3) - 1, width / 2, height / 3, color, color]
    end

    def format_appropriately(img)
      img.rect( *dot ) if latin_char >= 'w'

      case latin_char
      when 's'
        img
      when 't'
        img.rotate_right!
      when 'u'
        img.rotate_180!
      when 'v'
        img.rotate_left!
      when 'w'
        img
      when 'x'
        img.rotate_right!
      when 'y'
        img.rotate_180!
      when 'z'
        img.rotate_left!
      end
    end
  end
end
