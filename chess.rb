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
    i = 0
     
    loop do
      current_player = players[i]
      waiting_player = players[i-1]

      board.render

      if current_player.in_check?(board, waiting_player)
        break if current_player.checkmate?(board)

        puts "Player #{current_player.num}, you're in check!"
      end

      begin
       
        start_pos, end_pos = current_player.get_move
        
        board.valid_move?(start_pos, current_player)

        target_piece = board[start_pos]
        
        target_piece.valid_move?(board, start_pos, end_pos)

        virtual_board = board.dup_board

        board.move_piece(virtual_board, start_pos, end_pos)

      rescue RuntimeError => e
        puts "#{e.message}"
        retry
      end

      board.move_piece(board, start_pos, end_pos) #actual updating of board's grid array

      i = i == 0 ? 1 : 0
      @turn += 1
    end

    puts "Player #{players[i].num}, you have been mated!!"
  end

end

ChessGame.new.play