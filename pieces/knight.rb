require_relative 'piece'

class Knight < Piece
  def initialize(player)
    super(player)
    @symbol = "N"
  end
  
  KNIGHT_OFFSETS = [
                    [-1, 2], [ 1, 2],
                    [ 2, 1], [ 2,-1],
                    [-1,-2], [ 1,-2],
                    [-2, 1], [-2, -1]
                   ]
  
  def moves(board, start_pos)
    x, y = start_pos
    moves = []
    
    KNIGHT_OFFSETS.each do |offset|
      end_x, end_y = offset
      
      moves << [x+end_x,y+end_y] if on_board?([x+end_x,y+end_y]) && (board.empty?([x+end_x,y+end_y]) || enemy?(board[[x+end_x,y+end_y]]))
    end
    
    moves
  end
  
  def valid_move?(board, start_pos, end_pos)
    if self.moves(board, start_pos).include?(end_pos)
      return true
    else       
      raise RuntimeError.new "Invalid move - Your Knight can't move there."
    end
  end
end