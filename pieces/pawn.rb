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
    moves << [x, y+valid_dir] if on_board?([x, y+valid_dir]) && board.empty?([x, y+valid_dir]) 

    #diagonal attack
    moves << [x-1, y+valid_dir] if enemy?(board[[x-1, y+valid_dir]]) #board[] method makes this syntax weird
    moves << [x+1, y+valid_dir] if enemy?(board[[x+1, y+valid_dir]]) #perhaps move method to board class
    
    moves
  end
end