require './piece.rb'
require "colorize"

class ChessGame
  attr_accessor :players, :board
  def initialize
    @players = [Player.new(1), Player.new(2)]
    @board = Board.new(self)

    @turn = 1 #starts with player 1
  end

  def move_pieces
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

    (0..7).to_a.reverse.each do |row|
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
      puts ""
      tile_color = tile_color == :cyan ? :yellow : :cyan
    end

    nil
  end

  private

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

# class Tile
#   attr_accessor :occupier
#
#   def initialize(board, position)
#     @board, @position = board, position
#     @occupier = nil
#     @occupied = false
#   end
#
#   def occupied?
#     #if @occupier
#   end
#
#   def occupied_by
#     @occupier
#   end
#
# end


class Player
  attr_accessor :pieces
  attr_reader :num

  def initialize(num)
    @num = num
    @pieces = [] #an array containing all of the initial pieces

    create_pieces
  end

  private

  def create_pieces

    self.pieces << Rook.new(num)
    self.pieces << Knight.new(num)
    self.pieces << Bishop.new(num)
    self.pieces << Queen.new(num)
    self.pieces << King.new(num)
    self.pieces << Bishop.new(num)
    self.pieces << Knight.new(num)
    self.pieces << Rook.new(num)

    8.times {self.pieces << Pawn.new(num) }

    nil
  end
end