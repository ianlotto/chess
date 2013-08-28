class Piece
  attr_reader :player
  attr_accessor :position, :symbol

  def initialize(player)
    @player = player
    @position = nil
  end
  
  def on_board?(move)
    move.all? { |coord| coord.between?(0,7) }
  end
  
  def enemy?(piece)
    piece && (self.player != piece.player)
  end
end