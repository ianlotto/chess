class Piece
  attr_reader :player
  attr_accessor :position, :symbol

  def initialize(player)
    @player = player
    @position = nil
  end
  
  #this method may be able to store some stuff here
  def moves(board, start_pos)
  end
  
  def on_board?(move)
    move.all? { |coord| coord.between?(0,7) }
  end
  
  def enemy?(piece)
    piece && (self.player != piece.player)
  end
  
  def valid_move?(board, start_pos, end_pos)
    if self.moves(board, start_pos).include?(end_pos)
      return true
    else       
      raise RuntimeError.new "Invalid move - Your #{ (self.class).to_s.downcase } can't move there!"
    end
  end
end