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

      grid[row].each do |tile|

        if tile
          symbol = tile.symbol
          symbol_color = tile.player == 1 ? :white : :black
        else
          symbol = " "
          symbol_color = :white
        end

        print " #{symbol} ".colorize(:color => symbol_color,
                                     :background => tile_color)

        tile_color = tile_color == :cyan ? :yellow : :cyan
      end
      render_row_numbers(row)
      puts ""

      tile_color = tile_color == :cyan ? :yellow : :cyan #switch tile color for next row
    end

    render_col_letters

    nil
  end

  def move_piece(start, finish)
    piece = grid[start[1]][start[0]]
    grid[start[1]][start[0]] = nil

    piece.position = finish
    grid[finish[1]][finish[0]] = piece
  end

  def valid_move?(start, player)
    piece = grid[start[1]][start[0]]

    unless piece && piece.player == player.num
      raise RuntimeError.new "Invalid move - You can't move from that space."
    end
  end

  #take the [x,y] coordinates and returns the spot in 2d grid array
  def to_grid(pos)
    grid[pos[1]][pos[0]]
  end

  private

  def render_row_numbers(row)
    print " #{row+1} "
  end

  def render_col_letters
    print "   "
    8.times { |i| print " #{ChessGame::LETTER_MAP.key(i).upcase} " }
    puts ""
  end

  def generate_board
    self.grid = Array.new(8) do |row|
      Array.new(8)
    end

    place_pieces
  end

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