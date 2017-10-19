class Asteroid
  include Destructable

  def initialize(window, size = 'large')
    @window = window
    @size = size
    @image = Gosu::Image.new(@window, "assets/asteroid-#{@size}-1.png", false)

    @x, @y, @angle = rand(@window.width), rand(@window.height / 2), rand(360)
    @speed_modifier = 2
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def move
    @x += @speed_modifier * Math.sin(Math::PI / 180 * @angle)  
    @y += -@speed_modifier * Math.cos(Math::PI / 180 * @angle)  

    @x %= @window.width
    @y %= @window.height
  end

  def hitbox
    hitbox_x = ((@x - @image.width/2).to_i..(@x + @image.width/2).to_i).to_a
    hitbox_y = ((@y - @image.width/2).to_i..(@y + @image.width/2).to_i).to_a
    {:x => hitbox_x, :y => hitbox_y}
  end

  def kill
    super
    smash
  end

  def smash
    speed = 0 
    particle_asteroids = case @size
      when 'large'
        speed = 2
        Array.new(2) { Asteroid.new(@window, 'medium') }
      when 'medium'
        speed = 2.5
        Array.new(2) { Asteroid.new(@window, 'small') }
      else
        []
      end
    particle_asteroids.each do |asteroid|
      asteroid.setup(@x, @y, rand(0) * speed + 0.5)
    end
  end

  def setup(x, y, speed)
    @x, @y, @speed_modifier = x, y, speed
    @angle = rand(360)
    self
  end
end
