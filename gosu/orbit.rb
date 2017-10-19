require 'gosu'

class SolarSystem < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "Orbiter"

    @sun = Planet.new(self)
  end

  def update
    draw
  end

  def draw
    @sun.draw
  end
end

class Planet
  def initialize(window)
    @image = Gosu::Image.new(window, "sun.png", false)
    @x = 400
    @y = 300
  end

  def draw
    @image.draw(@x, @y, 0)
  end
end

SolarSystem.new.show
