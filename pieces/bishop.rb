require_relative 'piece'
require_relative "move_rules"

class Bishop < Piece
  include MoveRules

  def initialize(player)
    super(player)
    @symbol = "B"
  end



  def moves(board, start_pos)
    moves = directions(board, start_pos, DIAGONALS)

    moves
  end
end