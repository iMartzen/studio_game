require "minitest/autorun"

require_relative "../../lib/studio_game/playable"

module StudioGame
  class PlayableTest < Minitest::Test
    class PlayableObject
      include Playable
      attr_accessor :health
      
      def initialize(health=100)
        @health = health
      end
    end
    
    def setup
      @playable = PlayableObject.new(100)
    end
    
    def test_boost_increases_health_by_15
      initial_health = @playable.health
      @playable.boost
      assert_equal initial_health + 15, @playable.health
    end
    
    def test_drain_decreases_health_by_10
      initial_health = @playable.health
      @playable.drain
      assert_equal initial_health - 10, @playable.health
    end
  end
end