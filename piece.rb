class Piece
  attr_reader :player
  attr_accessor :position, :symbol

  include Utilities

  def initialize(player)
    @player = player
    @position = nil
  end

  def occupied?(grid, pos)
    to_grid(grid, pos).is_a? Piece
  end

end

class Pawn < Piece
  def initialize(player)
    super(player)
    @symbol = "p"
  end

  def valid_move?(grid, start_pos, end_pos)
    start_x, start_y = start_pos
    end_x, end_y = end_pos

    valid = false

    start_row = self.player == 1 ? 1 : 6
    valid_dir = self.player == 1 ? 1 : -1

    if start_x == end_x #moving forward
      #can move 2 spaces forward on first move
      if (end_y - start_y).abs == 2
        valid = true if start_y == start_row and (end_y - start_y) == valid_dir*2
        valid = false if occupied?(grid, [end_x, end_y-valid_dir])
      end

      #1 space forward every other move
      valid = true if (end_y - start_y) == valid_dir
      valid = false if occupied?(grid, end_pos)
    else # we're attacking
      valid = true if (start_x - end_x).abs == 1 and occupied?(grid, end_pos) and
      (end_y - start_y) == valid_dir
    end

    raise RuntimeError.new "Invalid move - Your pawn can't move there." unless valid

    valid
  end

end

class Rook < Piece
  def initialize(player)
    super(player)
    @symbol = "R"
  end

  def move
    #move rules assigned here
  end
end

class Knight < Piece
  def initialize(player)
    super(player)
    @symbol = "N"
  end

  def move
    #move rules assigned here
  end
end

class Bishop < Piece
  def initialize(player)
    super(player)
    @symbol = "B"
  end

  def move
    #move rules assigned here
  end
end

class King < Piece
  MOVES = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ]


  def initialize(player)
    super(player)
    @symbol = "K"
  end

  def move
    #move rules assigned here
  end
end

class Queen < Piece
  def initialize(player)
    super(player)
    @symbol = "Q"
  end

  def move
    #move rules assigned here
  end
end