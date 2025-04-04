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

loop do
  print "\nHow many game rounds? ('quit' to exit) "
  answer = gets.chomp.downcase 

  case answer
	when /^\d+$/ # types number
		game.play(answer.to_i)
	when "quit", "exit" # types quit
		game.print_stats
		break
	else 
		puts "Please enter a number or 'quit'"
	end
end

emojis()
