class Automaton::Board

  MAX_X = 4
  MAX_Y = 4

  ALLOWABLE_X = 0..MAX_X
  ALLOWABLE_Y = 0..MAX_Y

  def placeable?(x, y)
    return false if x < 0 || y < 0
    return false if x > MAX_X || y > MAX_Y
    true
  end

end
