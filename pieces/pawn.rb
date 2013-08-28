require_relative 'piece'

class Pawn < Piece
  def initialize(player)
    super(player)
    @symbol = "p"
  end
  
  def moves(board, start_pos)
    x, y = start_pos
    moves = []
    
    start_row = self.player == 1 ? 1 : 6
    valid_dir = self.player == 1 ? 1 : -1
    
    #move forward 2 spaces on first move
    moves << [x, y+(valid_dir*2)] if start_row == y && (board.empty?([x, y+valid_dir]) && board.empty?([x, y+(valid_dir*2)]))
    
    #move forward 1 space
    moves << [x, y+valid_dir] if board.empty?([x, y+valid_dir]) 

    #diagonal attack
    moves << [x-1, y+valid_dir] if board.occupied?([x-1, y+valid_dir])
    moves << [x+1, y+valid_dir] if board.occupied?([x+1, y+valid_dir])
    
    p moves.select { |move| on_board?(move) }
    moves.select { |move| on_board?(move) } #on_board defined in Piece Class
  end
  
  def valid_move?(board, start_pos, end_pos)
    if self.moves(board, start_pos).include?(end_pos)
      return true
    else       
      raise RuntimeError.new "Invalid move - Your pawn can't move there."
    end
  end

end