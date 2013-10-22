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
    return false unless valid_position? pos_x, pos_y, facing
    @pos_x  = pos_x
    @pos_y  = pos_y
    @facing = ALLOWABLE_DIRECTIONS.invert[facing]
    true
  end

end
