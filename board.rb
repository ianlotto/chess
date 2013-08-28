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
  
  #converts [x,y] input to 2d grid array position
  def [](pos) 
    self.grid[pos[1]][pos[0]]
  end

  #updates values of the grid array
  def move_piece(start, finish)
    piece = grid[start[1]][start[0]]
    grid[start[1]][start[0]] = nil #start position is now empty

    piece.position = finish #update position attribute of piece
    grid[finish[1]][finish[0]] = piece #finish position now contains the new piece
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