class Automaton::Daneel

  ALLOWABLE_DIRECTIONS = { 0 => "north", 1 => "east", 2 => "south", 3 => "west" }

  attr_accessor :board, :facing, :pos_x, :pos_y

  def initialize(board)
    @board  = board
    @facing = nil
    @pos_x  = nil
    @pos_y  = nil
  end

  def facing
    ALLOWABLE_DIRECTIONS[@facing]
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

  def turn_left
    return false unless placed?

    if @facing == ALLOWABLE_DIRECTIONS.first[0]
      @facing = ALLOWABLE_DIRECTIONS.max[0]
    else
      @facing -= 1
    end
  end

  def turn_right
    return false unless placed?

    if @facing == ALLOWABLE_DIRECTIONS.max[0]
      @facing = ALLOWABLE_DIRECTIONS.first[0]
    else
      @facing += 1
    end
  end

  def move
    return false unless placed?

    if @facing == 0     #north
      @pos_y += 1 if board.placeable?(@pos_x, @pos_y+1)

    elsif @facing == 2  #south
      @pos_y -= 1 if board.placeable?(@pos_x, @pos_y-1)

    elsif @facing == 1  #east
      @pos_x += 1 if board.placeable?(@pos_x+1, @pos_y)

    elsif @facing == 3  #west
      @pos_x -= 1 if board.placeable?(@pos_x-1, @pos_y)

    end
  end

  def report
    placed? ? "My current position is X:#{pos_x} Y:#{pos_y} facing #{facing}" : "I have no idea where I am"
  end

  def placed?
    !(pos_y.nil? && pos_y.nil?)
  end

end
