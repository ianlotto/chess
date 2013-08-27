module Utilities
  #take the [x,y] coordinates and returns the spot in 2d grid array
  def to_grid(arr,pos)
    arr[pos[1]][pos[0]]
  end
end