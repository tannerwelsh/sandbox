class World
  DEFAULT_WIDTH = 80
  DEFAULT_HEIGHT = 40

  attr_reader :grid

  def initialize(width = DEFAULT_WIDTH, height = DEFAULT_HEIGHT,  &contents)
    @width, @height = width, height

    @grid = Array.new(width * height) { contents.call }

    assign_neighbors_to_cells
  end

  def each_cell
    grid.each { |cell| yield cell }
  end

  def each_row
    grid.each_slice(@width)
  end

  def size
    grid.size
  end

  def sample_cell
    grid.sample
  end

  def to_s
    each_row.reduce("") do |board_str, row|
      board_str << row.map(&:to_s).join + "\n"
    end
  end

private

  def assign_neighbors_to_cells
    each_row.with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        neighbor_indices(row_index, col_index).each do |neighbor_row, neighbor_col|
          next unless (0...@height) === neighbor_row && (0...@width) === neighbor_col
          cell.neighbors << grid[(neighbor_row * @width) + neighbor_col]
        end
      end
    end
  end

  def neighbor_indices(row_index, col_index)
    above_left  = [row_index - 1, col_index - 1]
    above_mid   = [row_index - 1, col_index]
    above_right = [row_index - 1, col_index + 1]
    left        = [row_index, col_index - 1]
    right       = [row_index, col_index + 1]
    below_left  = [row_index + 1, col_index - 1]
    below_mid   = [row_index + 1, col_index]
    below_right = [row_index + 1, col_index + 1]

    [above_left, above_mid, above_right,
     left,                  right,
     below_left, below_mid, below_right]
  end
end
