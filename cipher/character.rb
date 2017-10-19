Dir['./characters/*.rb'].each do |character_class|
  require character_class
end

module PigdenCipher
  class Character
    DEFAULTS = {
      width: 16,
      height: 16,
      color: ChunkyPNG::Color::BLACK
    }

    attr_reader :latin_char, :opts

    def initialize(latin_char, opts = {})
      @latin_char = latin_char.downcase
      @opts = DEFAULTS.merge(opts)
    end

    def pigden_char
      return @pigden_char if @pigden_char

      if ('a'..'r') === latin_char
        # Letters "a" through "r" are displayed as square characters
        @pigden_char = Square.new(latin_char, opts)
      elsif ('s'..'z') === latin_char
        # Letters "s" through "z" are displayed as angled characters
        @pigden_char = Angled.new(latin_char, opts)
      elsif [' ', '.', ','].include? latin_char
        # Punctuation is displayed directly
        @pigden_char = Punctuation.new(latin_char, opts)
      else
        raise "Cannot translate #{latin_char} to pigden"
      end
    end

    def img
      pigden_char.img
    end

    def save(filename = default_filename)
      pigden_char.save(filename, interlace: true)
    end

  private

    def default_filename
      "images/#{latin_char}.png"
    end
  end
end
