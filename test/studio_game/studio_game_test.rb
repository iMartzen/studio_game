require "minitest/autorun"
require_relative "../../lib/studio_game"

module StudioGame
  class StudioGameTest < Minitest::Test
    def test_includes_all_required_files
      # If we can instantiate classes from all the required modules,
      # then we know the requires in studio_game.rb are working properly
      
      # Test Game class is available
      game = Game.new("Test Game")
      assert_instance_of Game, game
      
      # Test Player class is available
      player = Player.new("Test Player")
      assert_instance_of Player, player
      
      # Test ClumsyPlayer class is available
      clumsy_player = ClumsyPlayer.new("Clumsy")
      assert_instance_of ClumsyPlayer, clumsy_player
      
      # Test BerserkPlayer class is available 
      berserk_player = BerserkPlayer.new("Berserk")
      assert_instance_of BerserkPlayer, berserk_player
      
      # Test TreasureTrove module is available by accessing one of its constants
      assert_kind_of Enumerable, TreasureTrove::TREASURES
      # Assuming TREASURES is expected to be non-empty in normal scenarios
      refute_empty TreasureTrove::TREASURES, "TREASURES should not be empty under normal conditions"
    end
  end
end