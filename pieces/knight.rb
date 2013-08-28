require_relative 'piece'

class Knight < Piece
  def initialize(player)
    super(player)
    @symbol = "N"
  end

  def move
    #move rules assigned here
  end
end