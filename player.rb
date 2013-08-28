class Player
  attr_accessor :pieces
  attr_reader :num

  def initialize(num)
    @num = num
    @pieces = [] #an array containing all of the initial pieces

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