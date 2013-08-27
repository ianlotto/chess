require './piece.rb'
require "colorize"

class ChessGame
  attr_accessor :players, :board

  LETTER_MAP = {"a"=>0, "b"=>1, "c"=>2, "d"=>3,
                "e"=>4, "f"=>5, "g"=>6, "h"=>7}

  def initialize
    @players = [Player.new(1), Player.new(2)]
    @board = Board.new(self)

    @turn = 1 #starts with player 1
  end

  def move_pieces
  end

  def play
    i = 0
    loop do
      current_player = players[i]

      board.render

      begin
        start_pos, end_pos = current_player.get_move
        puts "#{start_pos} #{end_pos}"
      rescue RuntimeError => e
        puts "#{e.message}"
        retry
      end

      i = i == 0 ? 1 : 0 #switch turns
    end
  end

  private

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


class Player
  attr_accessor :pieces
  attr_reader :num

  def initialize(num)
    @num = num
    @pieces = [] #an array containing all of the initial pieces

    create_pieces
  end

  def get_move
    puts "Player #{self.num}, where do you wish to move? (q to quit)"
    move = gets.chomp.downcase.split(" ")

    quit if move[0] == 'q'

    if move.length != 2
      raise RuntimeError.new "Invalid input - Please separate coords with a space"
    else
      move.map { |pos| map_position(pos) }
    end
  end

  private

  def quit
    puts "Thanks for playing"
    exit
  end

  def map_position(position)
    #will take in a [letter][number] String and return and coordinate pair


    col, row = position.split("")

    unless ChessGame::LETTER_MAP[col] && row.to_i.between?(1,8)
      raise RuntimeError.new "Invalid Input - Please use A-H and 1-8"
    end

    [ChessGame::LETTER_MAP[col], (row.to_i)-1]
  end

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