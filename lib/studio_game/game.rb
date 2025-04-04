require_relative 'treasure_trove'

class Game
  attr_reader :title, :players

  def initialize(title)
    @title = title
    @players = []
    @treasures_found = Hash.new(0)
  end

  def roll_dice
    rand(1..6)
  end

  def add_player(player)
    @players << player
  end

  def load_players(from_file)
    File.readlines(from_file, chomp: true).each do |line|
      name, health = line.split(',')
      player = Player.new(name, health.to_i)
      add_player(player)
    end
  end

  def sorted_players
    @players.sort_by { |player| player.score }.reverse
  end

  def print_stats
    puts "\n Game Stats:"
    puts "-" * 30
    puts sorted_players
  end

  def high_score_entry(player)
    name = player.name.ljust(20, ".")
    score = player.score.round.to_s.rjust(5)
    "#{name}#{score}"
  end

  def save_high_scores(to_file = "high_scores.txt")
    File.open(to_file, "w") do |file|
      file.puts "#{@title} High Scores:"
      sorted_players.each do |player|
        file.puts high_score_entry(player)
      end
    end
  end

  def play(rounds = 1)
    puts "Before playing:"
    puts @players
    puts ""

    puts "The following treasures can be found:"
    puts TreasureTrove.treasure_items

    0.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do |player|
        number_rolled = roll_dice()
        case number_rolled
        when 1..2
          player.drain
          puts "#{player.name} got drained 😩"
        when 3..4
          puts "#{player.name} got skipped 😐"
        else 
          player.boost
          puts "#{player.name} got boosted 😁"
        end
        treasure = TreasureTrove.random_treasure
        player.found_treasure(treasure.name, treasure.points)
        puts "#{player.name} found a #{treasure.name} worth #{treasure.points} points."

      end
    end

    puts ""
    puts "After playing:"
    puts @players

    @players.each do |player|
      puts "\n#{player.name}'s treasure point totals:"
      player.found_treasures.each do |name, points|
        puts "#{name}: #{points}"
      end
      puts "total: #{player.points}"
    end

    puts "\nHigh Scores:"
    sorted_players.each do |player|
      puts high_score_entry(player)
    end
  end
end