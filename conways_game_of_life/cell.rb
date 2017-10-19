class Cell
  attr_accessor :neighbors

  def initialize(alive = false, neighbors = [])
    @alive = alive
    @neighbors = neighbors

    @will_survive = false
  end

  def live_or_die
    # APPLY THE LAWS OF CGOL
    # Any live cell with fewer than two live neighbours dies,
    #   as if caused by under-population.
    # Any live cell with two or three live neighbours lives on
    #   to the next generation.
    # Any live cell with more than three live neighbours dies,
    #   as if by overcrowding.
    # Any dead cell with exactly three live neighbours becomes
    #   a live cell, as if by reproduction.
    alive_neighbors = neighbors.count(&:alive?)

    if alive?
      die if alive_neighbors < 2 || alive_neighbors > 3
    else
      live if alive_neighbors == 3
    end
  end

  def advance
    @alive = will_survive?
  end

  def alive?
    @alive
  end

  def will_survive?
    @will_survive
  end

  def die
    @will_survive = false
  end

  def live
    @will_survive = true
  end

  def to_s
    alive? ? '•' : '.'
  end
end
