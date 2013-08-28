require_relative 'piece'

class Rook < Piece
  def initialize(player)
    super(player)
    @symbol = "R"
  end

  def move
    #move rules assigned here
  end
end