class Piece
  attr_reader :player
  attr_accessor :position

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
  end

  def move
    #move rules assigned here
  end
end

class Rook < Piece
  def initialize(player)
    super(player)
  end

  def move
    #move rules assigned here
  end
end

class Knight < Piece
  def initialize(player)
    super(player)
  end

  def move
    #move rules assigned here
  end
end

class Bishop < Piece
  def initialize(player)
    super(player)
  end

  def move
    #move rules assigned here
  end
end

class King < Piece
  def initialize(player)
    super(player)
  end

  def move
    #move rules assigned here
  end
end

class Queen < Piece
  def initialize(player)
    super(player)
  end

  def move
    #move rules assigned here
  end
end