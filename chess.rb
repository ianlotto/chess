require "colorize"

require './pieces.rb'
require './board.rb'
require './player.rb'

class ChessGame
  attr_accessor :players, :board

  LETTER_MAP = {"a"=>0, "b"=>1, "c"=>2, "d"=>3,
                "e"=>4, "f"=>5, "g"=>6, "h"=>7}

  def initialize
    @players = [Player.new(1), Player.new(2)]
    @board = Board.new(self)

    @turn = 1
  end

  def play
    i = 0 #toggles between the players array

    loop do
      current_player = players[i]

      board.render

      begin
        #all of these methods will raise an error if the
        #specified move is invalid for whatever reason

        start_pos, end_pos = current_player.get_move #get player's input, checks that it's on the board

        board.valid_move?(start_pos, current_player) #check board for existence of player's piece

        target_piece = board[start_pos] #get piece using custom [] method
        target_piece.valid_move?(board, start_pos, end_pos) #make sure the move is valid on a piece level

      rescue RuntimeError => e
        puts "#{e.message}"
        retry
      end

      board.move_piece(start_pos, end_pos) #actual updating of board's grid array

      i = i == 0 ? 1 : 0 #switch turns
      @turn += 1
    end
  end

end

c = ChessGame.new
c.play