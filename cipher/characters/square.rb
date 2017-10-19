module PigdenCipher
  class Square
    # Mapping of latin characters to pigden shapes
    ENCODE = {
      'a' => %i(right bottom),
      'b' => %i(right bottom left),
      'c' => %i(bottom left),
      'd' => %i(top right bottom),
      'e' => %i(top right bottom left),
      'f' => %i(top bottom left),
      'g' => %i(top right),
      'h' => %i(top right left),
      'i' => %i(top left),
      'j' => %i(right bottom dot),
      'k' => %i(right bottom left dot),
      'l' => %i(bottom left dot),
      'm' => %i(top right bottom dot),
      'n' => %i(top right bottom left dot),
      'o' => %i(top bottom left dot),
      'p' => %i(top right dot),
      'q' => %i(top right left dot),
      'r' => %i(top left dot)
    }

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

      lines_to_draw = ENCODE[latin_char].map { |line| lines[line] }

      lines_to_draw.each do |line_params|
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

      # Lines are represented by a set of 4 values: x0, y0, x1, y1
      # In this case we are drawing rectangles with fill and stroke color
      @lines ||= {
        :top    => [1, 1, width - 2, 2, color, color],
        :bottom => [1, height - 3, width - 2, height - 2, color, color],
        :left   => [1, 1, 2, height - 2, color, color],
        :right  => [width - 2, 1, width - 3, height - 2, color, color],
        :dot    => [(width / 2) - 1, (height / 2) - 1, width / 2, height / 2, color, color]
      }
    end
  end
end
