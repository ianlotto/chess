require_relative 'piece'
require_relative "move_rules"


class Rook < Piece
  include MoveRules

  def initialize(player)
    super(player)
    @symbol = "R"
  end

  def moves(board, start_pos)
    moves = directions(board, start_pos, ORTHOGONALS)

    moves
  end

end