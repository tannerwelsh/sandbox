class TogoPlayer
  class Ship
    attr_reader :x, :y, :length, :orientation

    def initialize(length)
      @length = length
    end

    def place(x, y, orientation)
      @x, @y, @orientation = x, y, orientation
    end

    def placed?
      x && y && orientation
    end

    def to_a
      [x, y, length, orientation]
    end
  end
end
