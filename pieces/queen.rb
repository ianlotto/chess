require_relative 'piece'
require_relative "move_rules"

class Queen < Piece
  include MoveRules

  def initialize(player)
    super(player)
    @symbol = "Q"
  end

  def moves(board, start_pos)
    moves = directions(board, start_pos, DIAGONALS)
    moves += directions(board, start_pos, ORTHOGONALS)

    moves
  end

end