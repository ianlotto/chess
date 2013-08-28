require_relative 'piece'

class Pawn < Piece
  def initialize(player)
    super(player)
    @symbol = "p"
  end

  def valid_move?(board, start_pos, end_pos)
    start_x, start_y = start_pos
    end_x, end_y = end_pos
    
    start_row = self.player == 1 ? 1 : 6
    valid_dir = self.player == 1 ? 1 : -1
    
    valid = false

    if start_x == end_x #moving forward
      #can move 2 spaces forward on first move
      if (end_y - start_y).abs == 2
        valid = true if start_y == start_row and (end_y - start_y) == valid_dir*2
        valid = false if board.occupied?([end_x, end_y-valid_dir])
      end

      #1 space forward every other move
      valid = true if (end_y - start_y) == valid_dir
      valid = false if board.occupied?(end_pos)
    else # we're attacking
      valid = true if (start_x - end_x).abs == 1 and board.occupied?(end_pos) and
      (end_y - start_y) == valid_dir
    end

    raise RuntimeError.new "Invalid move - Your pawn can't move there." unless valid

    valid
  end

end