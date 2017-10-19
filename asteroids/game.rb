#!/usr/bin/env ruby -w

require 'gosu'

Dir['./lib/*.rb'].each do |file|
  p file
  require file
end
# require './lib/destructable'

# require './lib/player'
# require './lib/asteroid'
# require './lib/projectile'

class GameWindow < Gosu::Window
  attr_reader :width, :height, :bg_image, :player, :asteroids, :projectiles

  def initialize
    @width, @height = 640, 480
    super(@width, @height, false)

    @bg_image  = Gosu::Image.new(self, 'assets/background.png', true)
    @life_img  = Gosu::Image.new(self, 'assets/ship.png', false)

    @player    = Player.new(self)
    @asteroids = Array.new(rand(5)) { Asteroid.new(self) }
    @projectiles = []
  end

  def update
    app_commands
    control_player unless player.dead?

    projectiles.reject!(&:dead?)
    asteroids.reject!(&:dead?)

    player.move unless player.dead?
    projectiles.each(&:move)
    asteroids.each(&:move)

    detect_collisions
  end

  def draw
    bg_image.draw(0, 0, 0)
    player.draw unless player.dead?
    projectiles.each(&:draw)
    asteroids.each(&:draw)

    draw_lives
  end

  def button_down(id)
    if id == Gosu::KbSpace
      projectiles << Projectile.new(self, player) unless player.dead?
    end
  end

  def app_commands
    if button_down? Gosu::KbQ
      close
    end
  end

  def control_player
    if button_down? Gosu::KbLeft
      player.turn_left
    end

    if button_down? Gosu::KbRight
      player.turn_right
    end

    if button_down? Gosu::KbUp
      player.accelerate
    end
  end

  def detect_collisions
    projectiles.each do |projectile|
      asteroids.each do |asteroid|
        if collision?(projectile, asteroid)
          projectile.kill
          @asteroids += asteroid.kill
        end
      end
    end

    asteroids.each do |asteroid|
      if collision?(asteroid, player)
        player.kill
      end
    end
  end

  def collision?(obj_a, obj_b)
    hitbox_a, hitbox_b = obj_a.hitbox, obj_b.hitbox
    common_x = hitbox_a[:x] & hitbox_b[:x]
    common_y = hitbox_a[:y] & hitbox_b[:y]
    common_x.size > 0 && common_y.size > 0
  end

  def draw_lives
    if player.lives > 0
      x = 10
      player.lives.times do
        @life_img.draw(x, 10, 0)
        x += 20
      end
    end
  end
end

window = GameWindow.new
window.show
