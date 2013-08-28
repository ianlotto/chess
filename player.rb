class Player
  attr_accessor :pieces, :captured_pieces
  attr_reader :num

  def initialize(num)
    @num = num
    @pieces = [] #an array containing all of the initial pieces
    @captured_pieces = [] #an array holding all that player's OWN captured pieces
    create_pieces
  end

  def get_move
    puts "Player #{self.num}, where do you wish to move? ('q' to quit)"
    move = gets.chomp.downcase.split(" ")

    quit if move[0] == 'q'

    if move.length != 2
      raise RuntimeError.new "Invalid input - Please separate coords with a space"
    else
      move.map { |pos| map_position(pos) }
    end
  end

  def get_all_moves(board)

    all_moves = {}
    pieces.each do |piece|
      all_moves[piece.position] = piece.moves(board, piece.position)
    end

    #p all_moves
    all_moves
  end

  def get_all_destinations(board)
    get_all_moves(board).values.flatten(1)
  end

  def in_check?(board, player)
    player.get_all_destinations(board).include?(kings_coordinates)
  end

  def kings_coordinates
    king = pieces.select { |p| p.class == King }
    king[0].position
  end

  def checkmate?(board)

    get_all_moves(board).each do |start_pos, moves|
      moves.each do |end_pos|
        virtual_board = board.dup_board
        #we don't want check error to bubble up here
        #just keep going and check the next case
        begin
          #we have a potential move here!
          return false if board.move_piece(virtual_board, start_pos, end_pos)
        rescue
          next
        end
      end
    end
    #no such luck, this player loses!
    true
  end

  private

  def quit
    puts "Thanks for playing!"
    exit
  end

  #will take in a [letter][number] String and return and coordinate pair
  def map_position(position)
     coords = position.split("")
     col, row = coords

    unless coords.length == 2 && ChessGame::LETTER_MAP[col] && row.to_i.between?(1,8)
      raise RuntimeError.new "Invalid Input - Please use A-H and 1-8"
    end

    [ChessGame::LETTER_MAP[col], (row.to_i)-1]
  end

  def create_pieces

    self.pieces << Rook.new(self)
    self.pieces << Knight.new(self)
    self.pieces << Bishop.new(self)
    self.pieces << Queen.new(self)
    self.pieces << King.new(self)
    self.pieces << Bishop.new(self)
    self.pieces << Knight.new(self)
    self.pieces << Rook.new(self)

    8.times {self.pieces << Pawn.new(self) }

    nil
  end
end