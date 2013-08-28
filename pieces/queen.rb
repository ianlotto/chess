require_relative 'royalty'
require_relative "move_rules"

class Queen < Royalty

  def initialize(player)
    super(player)
    @symbol = "Q"
  end

end