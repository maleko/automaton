class Automaton::Daneel

  ALLOWABLE_DIRECTIONS = %w{ north south east west }

  def initialize(board)
    @board = board
  end

  def board
    @board
  end

  def placed_at(pos_x, pos_y, facing)
    ALLOWABLE_DIRECTIONS.include?(facing) && board.placeable?(pos_x, pos_y)
  end

end
