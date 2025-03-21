###
# Amount of times to repeat the string
###
10.times do
  puts "Howdy!"
end

# or

10.times { puts "Howdy!" }

###
# Up to
### 
5.upto(8) do |num|
  puts "#{num} alligator "
end

# or

5.upto(8) { |num| puts "#{num} alligator " }

###
# Down to 
###
3.downto(1) do |num|
  puts "launch in #{num}"
end

# or

3.downto(1) { |num| puts "launch in #{num}" }

###
# Each
###
words = %w[dog zebra elephant chimpanzee]

words.each do |word|
  puts word.length
end

# or

words.each { |word| puts word.length }