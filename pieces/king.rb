require_relative 'piece'

class King < Piece
  MOVES = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ]


  def initialize(player)
    super(player)
    @symbol = "K"
  end

  def move
    #move rules assigned here
  end
end