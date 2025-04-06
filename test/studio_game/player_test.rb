require "minitest/autorun"

require_relative "../../lib/studio_game/player"

module StudioGame
  class PlayerTest < Minitest::Test
    def test_has_a_capitalized_name
      player = Player.new("finn", 60)
    
      assert_equal "Finn", player.name
    end

    def test_computes_score_as_sum_of_health_and_length_of_name
      player = Player.new("finn", 60)
    
      assert_equal 64, player.score
    end

    def test_return_properly_formatted_string
      player = Player.new("finn", 60)
    
      assert_equal "I'm Finn with a health of 60 and a score of 64.", player.to_s
    end

    def test_boost_increases_health_by_15
      player = Player.new("finn", 60)
    
      player.boost
    
      assert_equal 75, player.health
    end

    def test_drain_decreases_health_by_10
      player = Player.new("finn", 60)
    
      player.drain
    
      assert_equal 50, player.health
    end
    
    def test_name_can_be_changed_and_is_capitalized
      player = Player.new("finn", 60)
      
      player.name = "jake"
      
      assert_equal "Jake", player.name
    end
    
    def test_has_empty_treasures_initially
      player = Player.new("finn", 60)
      
      assert_empty player.found_treasures
      assert_equal 0, player.points
    end
    
    def test_can_find_treasure
      player = Player.new("finn", 60)
      
      player.found_treasure("sword", 50)
      
      assert_equal 50, player.points
      assert_equal({"Sword" => 50}, player.found_treasures)
    end
    
    def test_can_find_multiple_treasures
      player = Player.new("finn", 60)
      
      player.found_treasure("sword", 50)
      player.found_treasure("coin", 25)
      player.found_treasure("sword", 25)
      
      assert_equal 100, player.points
      assert_equal({"Sword" => 75, "Coin" => 25}, player.found_treasures)
    end
    
    def test_can_be_created_from_csv_string
      player = Player.from_csv("finn,60")
      
      assert_equal "Finn", player.name
      assert_equal 60, player.health
    end
    
    def test_handles_invalid_health_in_csv
      original_stdout = $stdout
      $stdout = StringIO.new
      
      player = Player.from_csv("finn,invalid")
      
      output = $stdout.string
      $stdout = original_stdout
      
      assert_equal "Finn", player.name
      assert_equal 100, player.health  # Default health
      assert_match(/Ignored invalid health: invalid/, output)
    end
  end
end
