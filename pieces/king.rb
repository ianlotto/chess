require_relative 'royalty'
require_relative "move_rules"

class King < Royalty

  def initialize(player)
    super(player)
    @symbol = "K"
  end

end