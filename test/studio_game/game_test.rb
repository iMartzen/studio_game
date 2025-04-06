require "minitest/autorun"

require_relative "../../lib/studio_game/game"
require_relative "../../lib/studio_game/player"

module StudioGame
  class GameTest < Minitest::Test

    def setup
      @game = Game.new("Test Me")
    
      @player_1 = Player.new("A", 60)
      @player_2 = Player.new("B", 75)
      @player_3 = Player.new("C", 100)
      
      $stdout = StringIO.new
    end
    
    def teardown
      $stdout = STDOUT
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
    
    def test_sorted_players_returns_players_by_score_descending
      @game.add_player(@player_1)
      @game.add_player(@player_2)
      @game.add_player(@player_3)
      
      # Note: Game sorts players by score (health + name.length), NOT by total points
      # @player_3 = 100 health + 1 char = 101 score
      # @player_2 = 75 health + 1 char = 76 score
      # @player_1 = 60 health + 1 char = 61 score
      
      sorted = @game.sorted_players
      
      # Players should be sorted by score (health + name.length), not including treasure points
      expected_order = [@player_3, @player_2, @player_1]
      assert_equal expected_order, sorted
    end
    
    def test_print_stats_outputs_player_stats
      @game.add_player(@player_1)
      
      @game.print_stats
      
      assert_includes $stdout.string, "Game Stats"
      assert_includes $stdout.string, @player_1.name
    end
    
    def test_high_score_entry_formats_player_score
      entry = @game.high_score_entry(@player_1)
      
      # Score = health (60) + name.length (1) = 61
      assert_equal "A...................   61", entry
    end
    
    def test_save_high_scores_creates_file_with_scores
      @game.add_player(@player_1)
      @game.add_player(@player_2)
      
      test_file = "test_high_scores.txt"
      @game.save_high_scores(test_file)
      
      assert File.exist?(test_file)
      content = File.read(test_file)
      
      assert_includes content, "Test Me High Scores:"
      # Score = health (75) + name.length (1) = 76 for player_2
      assert_includes content, "B...................   76"
      # Score = health (60) + name.length (1) = 61 for player_1
      assert_includes content, "A...................   61"
      
      File.delete(test_file)
    end
    
    def test_load_players_adds_players_from_file
      filename = "test_players.csv"
      File.open(filename, "w") do |file|
        file.puts "Player1,100"
        file.puts "Player2,120"
      end
      
      @game.load_players(filename)
      
      assert_equal 2, @game.players.size
      assert_equal "Player1", @game.players[0].name
      assert_equal 100, @game.players[0].health
      assert_equal "Player2", @game.players[1].name
      assert_equal 120, @game.players[1].health
      
      File.delete(filename)
    end
    
    def test_load_players_handles_missing_file
      non_existent_file = "no_such_file.csv"
      
      # Capture exit call without actually exiting
      begin
        old_stderr = $stderr
        $stderr = StringIO.new
        
        assert_raises(SystemExit) do
          @game.load_players(non_existent_file)
        end
        
        assert_includes $stdout.string, "Whoops, #{non_existent_file} not found!"
      ensure
        $stderr = old_stderr
      end
    end
    
    def test_roll_dice_returns_number_between_1_and_6
      100.times do
        result = @game.roll_dice
        assert result.between?(1, 6)
      end
    end
    
    def test_roll_dice_audits_number
      # We'll verify that the audit method is called with the rolled number
      audit_called = false
      audit_number = nil
      
      @game.stub(:audit, ->(number) { 
        audit_called = true
        audit_number = number
      }) do
        number_rolled = @game.roll_dice
        assert audit_called
        assert_equal number_rolled, audit_number
      end
    end
    
    def test_play_adds_treasures_to_players
      @game.add_player(@player_1)
      
      # Mock the random_treasure method to return a consistent treasure
      treasure = TreasureTrove::Treasure.new("Diamond", 100)
      TreasureTrove.stub(:random_treasure, treasure) do
        @game.stub(:roll_dice, 4) do  # Use 4 to skip player (no health change)
          @game.play(1)
        end
      end
      
      assert_equal 100, @player_1.points
      assert_equal({"Diamond" => 100}, @player_1.found_treasures)
    end
    
    def test_play_with_multiple_rounds
      @game.add_player(@player_1)
      
      # Mock the random_treasure method to return a consistent treasure
      treasure = TreasureTrove::Treasure.new("Diamond", 100)
      TreasureTrove.stub(:random_treasure, treasure) do
        @game.stub(:roll_dice, 4) do  # Use 4 to skip player (no health change)
          @game.play(3)  # Play 3 rounds
        end
      end
      
      assert_equal 300, @player_1.points  # 3 rounds × 100 points
      assert_equal({"Diamond" => 300}, @player_1.found_treasures)
    end
  end
end