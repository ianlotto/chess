require './piece.rb'

class ChessGame
  attr_reader :players
  def initialize
    @board = Board.new(self)
    @players = [Player.new(1), Player.new(2)]

  end

  def play
  end
end

class Board
  attr_accessor :game, :grid

  def initialize(game)
    @game = game
    generate_board
  end

  private

  def generate_board
    self.grid = Array.new(8) do |row|
      Array.new(8) { |col| Tile. new(self, [row, col])}
    end

    place_pieces
  end

  def place_pieces

    game.players.each do |player|
      pos = player.num == 1 ? [0,0] : [0,7]

      player.pieces.each do |piece|
        col, row = pos
        #assign pieces to tiles
        self.grid[row][col].occupier = piece
        piece.position = pos

        if col < 8
          pos.last += 1
        else
          col = 0
          player.num == 1 ? row += 1 : row -= 1
        end

      end

    end

    nil
  end

end

class Tile
  attr_accessor :occupier

  def initialize(board, position)
    @board, @position = board, position
    @occupier = nil
    @occupied = false
  end

  def occupied?
    if @occupier
  end

  def occupied_by
    @occupier
  end

end



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

# class Hu
#
# class Knight < Piece