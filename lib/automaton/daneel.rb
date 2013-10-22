class Automaton::Daneel

  ALLOWABLE_DIRECTIONS = { 0 => "north", 1 => "east", 2 => "south", 3 => "west" }

  attr_accessor :board, :facing, :pos_x, :pos_y

  def initialize(board)
    @board  = board
    @facing = nil
    @pos_x  = nil
    @pos_y  = nil
  end

  def valid_position?(pos_x, pos_y, facing)
    ALLOWABLE_DIRECTIONS.values.include?(facing) && board.placeable?(pos_x, pos_y)
  end

  def placed_at(pos_x, pos_y, facing)
    if valid_position? pos_x, pos_y, facing
      @pos_x  = pos_x
      @pos_y  = pos_y
      @facing = ALLOWABLE_DIRECTIONS.invert[facing]
    else
      return false
    end
    true
  end

end
