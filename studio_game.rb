require_relative "lib/studio_game/player"
require_relative "lib/studio_game/game"

puts ""
puts "Let's play"
puts ""

def emojis(number = 25)
  emoji = "👾"
  puts emoji * number
end

player_1 = Player.new("finn", 60)
player_2 = Player.new("lucy", 90)
player_3 = Player.new("jase")
player_4 = Player.new("alex", 125)

game = Game.new("Winner Takes All")

game.add_player(player_1)
game.add_player(player_2)
game.add_player(player_3)
game.add_player(player_4)

emojis()
game.play(3)
game.print_stats
emojis()
