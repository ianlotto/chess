#Used to create virtual boards
class Array
  def deep_dup
    [].tap do |new_array|
         self.each do |el|
           new_array << (el.is_a?(Array) ? el.deep_dup : el)
         end
       end
     end


end

class Board
  attr_accessor :game, :grid

  def initialize(game)
    @game = game
    generate_board
  end

  def render
    tile_color = :yellow

    render_col_letters

    (0..7).to_a.reverse.each do |row|
      render_row_numbers(row)

      grid[row].each_with_index do |tile, i|

        if tile #occupied?
          symbol = tile.symbol
          symbol_color = tile.player == 1 ? :white : :black
        else #empty
          symbol = " "
          symbol_color = :white
        end

        print "#{symbol} ".colorize(:color => symbol_color, :background => tile_color)

        (tile_color = tile_color == :cyan ? :yellow : :cyan) unless i == 7
      end
      render_row_numbers(row)
      puts ""
    end
    render_col_letters

    nil
  end

  def valid_move?(start, player)
    piece = grid[start[1]][start[0]]

    unless piece && piece.player == player.num
      raise RuntimeError.new "Invalid move - You can't move from that space."
    end
  end

  def occupied?(pos)
    self[pos].is_a? Piece
  end

  #will still return true if called on a position off the grid
  #that should be OK
  def empty?(pos)
    self[pos].nil?
  end

  #converts [x,y] input to 2d grid array position
  def [](pos)
    self.grid[pos[1]][pos[0]]
  end

  def []=(pos, value)
    self.grid[pos[1]][pos[0]] = value
  end

  #updates values of the grid array
  #works on both the actual grid and virtual grids
  def move_piece(candidate_board, start, finish)

    piece = candidate_board.grid[start[1]][start[0]]
    #store the piece's position attribute
    original_position = piece.position

    candidate_board.grid[start[1]][start[0]] = nil #start position is now empty

    #update position attribute of piece
    #for both virtual and actual grids
    piece.position = finish

    #only remove the captured piece if we're working on the actual grid
    captured = remove_captured_piece(self[finish]) if self.occupied?(finish)

    candidate_board.grid[finish[1]][finish[0]] = piece #finish position now contains the new piece

    # consider refactoring
    #if move puts the current player in check, we need to revert the move
    if self.is_virtual?(candidate_board)
      if game.players[piece.player-1].in_check?(candidate_board, game.players[piece.player-2])
        restore_captured_piece(piece) if captured
        piece.position = original_position
        raise RuntimeError.new "Invalid move - Your king would be in check!"
      else
        piece.position = original_position
        restore_captured_piece(piece) if captured
      end
    end

  end

  #delete piece from other player's pieces array
  #Think about moving this to Player class.
  def remove_captured_piece(piece)
    game.players[piece.player-1].captured_pieces << game.players[piece.player-1].pieces.delete(piece)

    true
  end

  def restore_captured_piece(piece)
    popped = game.players[piece.player-2].captured_pieces.pop
    game.players[piece.player-2].pieces << popped

    nil
  end

  def is_virtual?(candidate)
    candidate.object_id != self.object_id
  end

  private

  def render_row_numbers(row)
    print " #{row+1} "
  end

  def render_col_letters
    print "   "
    8.times { |i| print "#{ChessGame::LETTER_MAP.key(i).upcase} " }
    puts ""
  end

  #builds the container grid
  def generate_board
    self.grid = Array.new(8) { |row| Array.new(8) }

    place_pieces
  end

  #places the pieces on the board from the players' pieces arrays
  def place_pieces
    game.players.each do |player|
      pos = player.num == 1 ? [0,0] : [0,7]

      player.pieces.each do |piece|
        col, row = pos

        self.grid[row][col] = piece #assign pieces to positions on board
        piece.position = [col, row] # set position attribute of each piece

        if col < 7
          pos[0] += 1
        else
          pos[0] = 0
          player.num == 1 ? pos[-1] += 1 : pos[-1] -= 1
        end
      end
    end

    nil
  end

end