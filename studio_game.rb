require_relative "lib/studio_game/player"
require_relative "lib/studio_game/game"

puts ""
puts "Let's play"
puts ""

def emojis(number = 25)
  emoji = "👾"
  puts emoji * number
end

game = Game.new("Winner Takes All")
players_file = File.join(__dir__, "players.csv")
game.load_players(ARGV.shift || players_file)

emojis()

loop do
  print "\nHow many game rounds? ('q, quit' to exit) "
  answer = gets.chomp.downcase 

  case answer
	when /^\d+$/ # types number
		game.play(answer.to_i)
	when "q", "quit", "exit" # types quit
		game.print_stats
		break
	else 
		puts "Please enter a number or 'quit'"
	end
end

game.save_high_scores
emojis()
