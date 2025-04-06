require_relative 'player'

module StudioGame
  class BerserkPlayer < Player
    def initialize(name, health = 100)
      super(name, health)
      @boost_count = 0
    end

    def berserk?
      @boost_count > 5
    end

    def boost
      super
      @boost_count += 1
      puts "#{@name} is berserk!" if berserk?
    end

    def drain
      berserk? ? boost : super
    end
  end
end