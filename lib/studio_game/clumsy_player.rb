require_relative 'player'

module StudioGame
  class ClumsyPlayer < Player
    attr_reader :boost_factor

    def initialize(name, health = 100, boost_factor = 1)
      super(name, health)
      @boost_factor = boost_factor
    end

    def boost
      @boost_factor.times { super }
    end
  end
end