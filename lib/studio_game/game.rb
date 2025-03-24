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

  def play(rounds = 1)
    puts "Before playing:"
    puts @players
    puts ""

    puts "The following treasures can be found:"
    TreasureTrove::TREASURES.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points"
    end

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
  end
end