class Piece
  attr_reader :player
  attr_accessor :position, :symbol

  def initialize(player)
    @player = player
    @position = nil
  end

  def position=(square)
    @position = square
  end

end

class Pawn < Piece
  def initialize(player)
    super(player)
    @symbol = "p"
  end

  def move
    #move rules assigned here
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