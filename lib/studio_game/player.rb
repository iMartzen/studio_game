require_relative 'playable'

module StudioGame
  class Player
    include Playable
    attr_reader :found_treasures, :name
    attr_accessor :health

    def initialize(name, health=100)
      @name = name.split(" ").map { |word| word.capitalize }.join(" ")
      @health = health
      @found_treasures = Hash.new(0)
    end

    def to_s
    "I'm #{@name} with a health of #{@health} and a score of #{score}."
    end

    def score
      @health + @name.length 
    end 

    def name=(new_name)
      @name = new_name.capitalize
    end

    def found_treasure(name, points)
      @found_treasures[name.capitalize] += points
    end
    
    def points
      @found_treasures.values.sum
    end

    def self.from_csv(line)
      name, health = line.split(',')
      Player.new(name, Integer(health))
    rescue ArgumentError
      puts "Ignored invalid health: #{health}"
      Player.new(name)
    end
  end
end