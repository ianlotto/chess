require_relative 'piece'

class Bishop < Piece
  def initialize(player)
    super(player)
    @symbol = "B"
  end

  def move
    #move rules assigned here
  end
end