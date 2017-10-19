class Projectile
  include Destructable

  def initialize(window, origin_obj)
    @window, @origin_obj = window, origin_obj
    @image = Gosu::Image.new(@window, 'assets/projectile.png', false)
    
    @x, @y, @angle = origin_obj.x, origin_obj.y, origin_obj.angle
    @speed_modifier = 7

    @dist_traveled, @max_dist = 0, 50
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
  
  def move
    @x += @speed_modifier * Math.sin(Math::PI / 180 * @angle)  
    @y += -@speed_modifier * Math.cos(Math::PI / 180 * @angle)  

    @x %= @window.width
    @y %= @window.height
    
    @dist_traveled += 1
    kill if @dist_traveled > @max_dist
  end

  def hitbox
    hitbox_x = ((@x - @image.width/2).to_i..(@x + @image.width/2).to_i).to_a
    hitbox_y = ((@y - @image.width/2).to_i..(@y + @image.width/2).to_i).to_a
    {:x => hitbox_x, :y => hitbox_y}
  end
end
