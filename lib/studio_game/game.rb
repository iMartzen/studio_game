class Game
  attr_reader :title, :players

  def initialize(title)
    @title = title
    @players = []
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
      end
    end

    puts ""
    puts "After playing:"
    puts @players
  end
end