class Piece
  attr_reader :player

  def initialize(player)
    @player = player
    @position = nil
  end

end

class Pawn < Piece
  def initialize(player)
    super(player)
  end

  def move
    #move rules assigned here
  end
end