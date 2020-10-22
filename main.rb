require_relative 'lib/question'
require 'rexml/document'

if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

file = File.new("#{__dir__}/data/data.xml", encoding: 'UTF-8')
doc = REXML::Document.new(file)
file.close

questions_answers = []

doc.elements.each('questions/question') do |item|
  question_answer_score = [item.text, item.attributes['answer'].to_s, item.attributes['score']]
  questions_answers << Question.new(
      question_answer_score[0],
      question_answer_score[1],
      question_answer_score[2]
  )
end

puts "Let's play..please answer my questions:"

counter = 0
score = 0

questions_answers.sample(5).each do |question_and_answer|
  time_start = Time.now
  puts "#{question_and_answer.question_text} (You have 5 sec for answer)"
  user_input = STDIN.gets.chomp
  time_answer = Time.now
  if user_input == question_and_answer.correct_answer && time_answer - time_start <= 5
    puts "That's right! You got (#{question_and_answer.score} points)"
    counter += 1
    score += question_and_answer.score
  elsif time_answer - time_start > 5
    puts "Your time is up! Right answer: #{question_and_answer.correct_answer}"
  elsif
    puts "Wrong. Right answer: #{question_and_answer.correct_answer}"
    end
end

puts "Right answers: #{counter} from 5"
puts "You got #{score} points"
