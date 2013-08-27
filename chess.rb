require './piece.rb'

class ChessGame
  def initialize
    @board = Board.new
    @players = [Player.new(1), Player.new(2)]

  end

  def play
  end
end

class Board
  attr_accessor :grid
  def initialize
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
    #assign pieces to tiles
  end

end

class Tile
  def initialize(board, position)
    @board, @position = board, position
    @occupied = false
    @occupier = nil
  end

  def occupied?
    @occupied
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
    8.times {self.pieces << Pawn.new(num) }
    self.pieces << Rook.new(num)
    self.pieces << Knight.new(num)
    self.pieces << Bishop.new(num)
    self.pieces << Queen.new(num)
    self.pieces << King.new(num)
    self.pieces << Bishop.new(num)
    self.pieces << Knight.new(num)
    self.pieces << Rook.new(num)

    nil
  end
end

# class Hu
#
# class Knight < Piece