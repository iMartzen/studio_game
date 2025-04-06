require "minitest/autorun"

require_relative "../../lib/studio_game/berserk_player"

module StudioGame
  class BerserkPlayerTest < Minitest::Test
    def setup
      @initial_health = 50
      @player = BerserkPlayer.new("berserker", @initial_health)
    end

    def test_has_a_capitalized_name
      assert_equal "Berserker", @player.name
    end

    def test_is_not_berserk_initially
      refute @player.berserk?
    end

    def test_becomes_berserk_after_six_boosts
      5.times { @player.boost }
      refute @player.berserk?
      
      @player.boost
      assert @player.berserk?
    end

    def test_gets_boost_instead_of_drain_when_berserk
      # Make the player berserk
      6.times { @player.boost }
      assert @player.berserk?
      
      # Initial health = 50 + (15 × 6) = 140
      expected_health_after_boost = @initial_health + (6 * 15)
      assert_equal expected_health_after_boost, @player.health
      
      # When berserk, drain becomes boost
      @player.drain
      expected_health_after_drain = expected_health_after_boost + 15
      assert_equal expected_health_after_drain, @player.health
    end
    
    def test_normal_drain_when_not_berserk
      # Not berserk yet
      2.times { @player.boost }
      refute @player.berserk?
      
      # Initial health = 50 + (15 × 2) = 80
      expected_health_after_boost = @initial_health + (2 * 15)
      assert_equal expected_health_after_boost, @player.health
      
      # When not berserk, drain works normally
      @player.drain
      expected_health_after_drain = expected_health_after_boost - 10
      assert_equal expected_health_after_drain, @player.health
    end
  end
end