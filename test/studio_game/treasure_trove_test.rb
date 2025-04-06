require "minitest/autorun"

require_relative "../../lib/studio_game/treasure_trove"

module StudioGame
  class TreasureTroveTest < Minitest::Test
    def test_treasure_has_name_and_points
      treasure = TreasureTrove::Treasure.new("crown", 90)
      
      assert_equal "crown", treasure.name
      assert_equal 90, treasure.points
    end
    
    def test_has_predefined_treasures
      expected = [
        TreasureTrove::Treasure.new("pie", 10),
        TreasureTrove::Treasure.new("coin", 25),
        TreasureTrove::Treasure.new("flute", 50),
        TreasureTrove::Treasure.new("compass", 65),
        TreasureTrove::Treasure.new("key", 80),
        TreasureTrove::Treasure.new("crown", 90),
        TreasureTrove::Treasure.new("star", 100)
      ]
      
      assert_equal expected, TreasureTrove::TREASURES
    end
    
    def test_returns_random_treasure
      treasure = TreasureTrove.random_treasure
      
      assert_includes TreasureTrove::TREASURES, treasure
    end
    
    def test_returns_formatted_treasure_items
      expected_items = [
        "A pie is worth 10 points",
        "A coin is worth 25 points",
        "A flute is worth 50 points",
        "A compass is worth 65 points",
        "A key is worth 80 points",
        "A crown is worth 90 points",
        "A star is worth 100 points"
      ]
      
      assert_equal expected_items, TreasureTrove.treasure_items
    end
  end
end