require "minitest/autorun"

require_relative "../../lib/studio_game/game"
require_relative "../../lib/studio_game/player"

class GameTest < Minitest::Test

  def setup
    @game = Game.new("Test Me")
  
    @player_1 = Player.new("A", 60)
    @player_2 = Player.new("B", 75)
    
    $stdout = StringIO.new
  end

  def test_has_no_players_initially
    assert_empty @game.players
  end

  def test_players_can_be_added
    @game.add_player(@player_1)
    @game.add_player(@player_2)

    refute_empty @game.players
    assert_equal [@player_1, @player_2], @game.players
  end

  def test_boost_player_if_high_number_rolled
    @game.add_player(@player_1)

    @game.stub(:roll_dice, 6) do
      @game.play()
      assert_equal 75, @player_1.health
    end
  end

  def test_skip_player_if_medium_number_rolled
    @game.add_player(@player_1)

    @game.stub(:roll_dice, 4) do
      @game.play()
      assert_equal 60, @player_1.health
    end
  end

  def test_drain_player_if_low_number_rolled
    @game.add_player(@player_1)

    @game.stub(:roll_dice, 2) do
      @game.play()
      assert_equal 50, @player_1.health
    end
  end
end