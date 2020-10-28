require_relative 'lib/parser'
require_relative 'lib/victorina'
require_relative 'lib/question'
require 'rexml/document'
require 'timeout'
require 'pry'

if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

QUESTIONS_COUNT = 5

data = Parser.from_file("#{__dir__}/data/data.xml")
game_set = Victorina.new(data.sample(QUESTIONS_COUNT))

puts "Let's play..please answer my questions:"

game_set.questions.each do |question|
  puts question
  begin
    Timeout::timeout(question.wait_time) do
      user_input = STDIN.gets.to_i

      if question.correct_answer?(user_input)
        puts "That's right! You got (#{question.points} points)"
        game_set.admit_points_and_right_answers(question.points, game_set.right_answers)
      else
        puts "Wrong. Right answer: #{question.right_answer}"
      end
    end
  rescue
    TimeoutError
    puts "Your time is up! Right answer: #{question.right_answer}"
  end
end

puts game_set.result
