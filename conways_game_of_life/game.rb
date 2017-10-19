require './cell'
require './world'
require './print_utils'

class Game
  PERCENT_ALIVE = 0.1

  attr_reader :world

  def initialize
    @world = World.new { Cell.new }

    let_there_be_life!
  end

  def step
    apply_laws
    next_generation
  end

  def run(cycles = 1000)
    clear_screen!

    cycles.times do |cycle|
      move_to_home!
      flush!
      reputs self.to_s

      step
      sleep 0.1
    end
  end

  def to_s
    world.to_s
  end

private

  def apply_laws
    world.each_cell(&:live_or_die)
  end

  def next_generation
    world.each_cell(&:advance)
  end

  def let_there_be_life!
    initial_alive_cells = world.size * PERCENT_ALIVE
    initial_alive_cells.to_i.times do
      world.sample_cell.live
    end
  end
end

game = Game.new
game.run
