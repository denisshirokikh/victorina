require_relative 'lib/parser'
require_relative 'lib/victorina'
require 'rexml/document'
require 'timeout'

if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

game_set = Parser.from_file("#{__dir__}/data/data.xml")
puts "Let's play..please answer my questions:"
puts game_set.to_s

counter = 0
score = 0

game_set.sample(5).each do |try|
  puts try.ask_question
  puts try.answers
  begin
    Timeout::timeout(try.wait_time) do
    user_input = STDIN.gets.to_i

      if try.correct_answer?(user_input)
        puts "That's right! You got (#{try.points} points)"
        counter += 1
        score += try.points
      else
        puts "Wrong. Right answer: #{try.right_answer}"

      end
    end
    rescue
      TimeoutError
      puts "Your time is up! Right answer: #{try.right_answer}"

    end
  end

puts "Right answers: #{counter} from 5"
puts "You got #{score} points"