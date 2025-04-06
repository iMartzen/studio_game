require "minitest/autorun"

require_relative "../../lib/studio_game/clumsy_player"

module StudioGame
  class ClumsyPlayerTest < Minitest::Test
    def setup
      @player = ClumsyPlayer.new("klutz", 100, 3)
    end

    def test_has_a_capitalized_name
      assert_equal "Klutz", @player.name
    end

    def test_has_boost_factor
      assert_equal 3, @player.boost_factor
    end

    def test_boost_applies_multiple_times_based_on_boost_factor
      initial_health = @player.health
      
      @player.boost
      
      # Health increase should be 15 × 3 = 45
      assert_equal initial_health + 45, @player.health
    end
    
    def test_computes_score
      assert_equal @player.health + @player.name.length, @player.score
    end
    
    def test_default_boost_factor_is_one
      player = ClumsyPlayer.new("default", 100)
      assert_equal 1, player.boost_factor
      
      initial_health = player.health
      player.boost
      assert_equal initial_health + 15, player.health
    end
  end
end