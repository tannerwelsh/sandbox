class Player
  include Destructable

  attr_reader :x, :y, :angle, :lives

  def initialize(window)
    @window = window
    @image = Gosu::Image.new(@window, 'assets/ship.png', false)
    @x, @y = @window.width / 2, @window.height / 2
    @velocity_x = @velocity_y = @angle = 0.0

    @lives = 3
  end
  
  def draw
    @image.draw_rot(@x, @y, 0, @angle)
  end
  
  def turn_left
    @angle -= 4.5
  end 

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @velocity_x += Gosu::offset_x(@angle, 0.18)
    @velocity_y += Gosu::offset_y(@angle, 0.18)
  end

  def move
    @x += @velocity_x
    @y += @velocity_y

    @x %= @window.width
    @y %= @window.height

    @velocity_x *= 1
    @velocity_y *= 1
  end

  def hitbox
    hitbox_x = ((@x - @image.width/2).to_i..(@x + @image.width/2).to_i).to_a
    hitbox_y = ((@y - @image.width/2).to_i..(@y + @image.width/2).to_i).to_a
    {:x => hitbox_x, :y => hitbox_y}
  end

  def kill
    super
    @lives -= 1
    if lives > 0
      respawn
      warp
    end
  end
  
  def warp(x = @window.width / 2, y = @window.height / 2)
    @velocity_x = @velocity_y = @angle = 0.0
    @x, @y = x, y
  end
end
