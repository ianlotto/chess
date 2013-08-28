class Piece
  attr_reader :player
  attr_accessor :position, :symbol

  include Utilities

  def initialize(player)
    @player = player
    @position = nil
  end

end