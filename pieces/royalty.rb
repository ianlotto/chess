require_relative 'piece'
require_relative "move_rules"

class Royalty < Piece
  include MoveRules

  def moves(board, start_pos)
    moves = directions(board, start_pos, DIAGONALS)
    moves += directions(board, start_pos, ORTHOGONALS)

    moves
  end

end