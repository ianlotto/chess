module MoveRules

  DIAGONALS = [[-1,1],[1,1],[1,-1],[-1,-1]]
  ORTHOGONALS = [[0,1],[1,0],[0,-1],[-1,0]]


  def directions(board, start_pos, offsets)
    moves = []
    x,y = start_pos

    offsets.each do |direction|
      current_pos = [x + direction[0], y + direction[1] ]

      while on_board?(current_pos) && (board.empty?(current_pos) || enemy?(board[current_pos]))
        moves << current_pos
        break if enemy?(board[current_pos])
        current_pos = [ current_pos[0] + direction[0], current_pos[1] + direction[1] ]
      end
    end

    moves

  end

end