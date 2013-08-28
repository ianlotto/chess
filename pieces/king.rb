require_relative 'piece'
require_relative "move_rules"

class King < Piece
  include MoveRules

  def initialize(player)
    super(player)
    @symbol = "K"
  end

  def moves(board, start_pos)
    moves = directions(board, start_pos, DIAGONALS)
    moves += directions(board, start_pos, ORTHOGONALS)

    moves
  end

end