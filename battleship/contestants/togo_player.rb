require_relative 'lib/togo/ship'

class TogoPlayer
  SHIP_SIZES = [5, 4, 3, 3, 2]

  def name
    "Togo Heihachiro"
  end

  def new_game
    # return an array of 5 arrays containing
    # [x,y, length, orientation]
    # e.g.
     [
       [0, 0, 5, :down],
       [4, 4, 4, :across],
       [9, 3, 3, :down],
       [2, 2, 3, :across],
       [9, 7, 2, :down]
     ]
  end

  def take_turn(state, ships_remaining)
    # state is the known state of opponents fleet
    # ships_remaining is an array of the remaining opponents ships
    @opponent_board = state
    @ships_remaining = ships_remaining

    return volley # [x, y] coordinates
  end

private

  attr_reader :opponent_board, :ships_remaining

  def volley
    opponent_board.each_with_index do |row, row_index|
      y = row_index
      x = row.index(:unknown)

      return [x, y] if x
    end
  end
end
