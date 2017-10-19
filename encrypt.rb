module Encrypter
  CHAR_SET = (0..255).map { |hex| hex.chr }

  class Encryption
    def initialize(opts = {})
      char_set = opts.fetch(:char_set) { CHAR_SET }

      @key = Key.new(char_set)
    end

    def encode(string)
      string.chars.map do |char|
        @key.encrypt(char)
      end.join
    end

    def decode(string)
      string.chars.map do |char|
        @key.decrypt(char)
      end.join
    end
  end

  class Key
    def initialize(char_set)
      @char_set = char_set.uniq.freeze
      @dest_set = CHAR_SET.dup.shuffle[0, orig_set.length].freeze
    end

    def encrypt(char)
      dest_set[ orig_set.index(char) ]
    end

    def decrypt(char)
      orig_set[ dest_set.index(char) ]
    end

  private

    def orig_set
      @orig_set ||= @char_set.uniq.freeze
    end

    def dest_set
    end

  end
end
