require "colorize"

require './piece.rb'
require './board.rb'
require './player.rb'


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
        #gets player's input
        start_pos, end_pos = current_player.get_move

        #checks board for piece existence there
        board.valid_move?(start_pos, current_player)

        #gets piece
        target_piece = board.to_grid(start_pos)
        #target_piece.valid_move?(start_pos, end_pos)

      rescue RuntimeError => e
        puts "#{e.message}"
        retry
      end

      board.move_piece(start_pos, end_pos)

      i = i == 0 ? 1 : 0 #switch turns
    end
  end

  private

end

c = ChessGame.new
c.play