class Player
  attr_reader :health, :found_treasures
  attr_accessor :name

  def initialize(name, health=100)
    @name = name.split(" ").map { |word| word.capitalize }.join(" ")
    @health = health
    @found_treasures = Hash.new(0)
  end

  def to_s
    "I'm #{@name} with a health of #{@health} and a score of #{score}"
  end

  def boost
    @health += 15
  end

  def drain
    @health = [@health - 10, 0].max
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
end