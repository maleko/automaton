class Automaton::Board

  MAX_X = 4
  MAX_Y = 4

  ALLOWABLE_X = 0..MAX_X
  ALLOWABLE_Y = 0..MAX_Y

  def placeable?(x, y)
    ALLOWABLE_X.include?(x) && ALLOWABLE_Y.include?(y)
  end

end
