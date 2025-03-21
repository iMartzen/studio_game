class Player
  attr_reader :health
  attr_accessor :name

  def initialize(name, health=100)
    @name = name.capitalize
    @health = health
  end

  def to_s
    "I'm #{@name} with a health of #{@health} and a score of #{score}."
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
end