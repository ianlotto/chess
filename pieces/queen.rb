require_relative 'piece'

class Queen < Piece
  def initialize(player)
    super(player)
    @symbol = "Q"
  end

  def move
    #move rules assigned here
  end
end