require_relative 'lib/question'
require_relative 'lib/answer'
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

game_set =
    doc.elements['questions'].elements.map do |item|
      right_answer = ''
      item.elements.each('./variants/variant/') { |variant| right_answer = variant.text if variant.attributes['right'] }
      Question.new(
          item.elements['text'].text,
          item.attributes['points'],
          item.attributes['minutes'],
          Answer.new(right_answer, item.elements['variants'].elements.map(&:text))
      )
    end

puts "Let's play..please answer my questions:"

counter = 0
score = 0

game_set.sample(5).each do |try|
  time_start = Time.now
  puts "#{try.text} (You have 5 sec for answer)"
  "#{try.answers.list.each {|variant| puts variant}}"
  user_input = STDIN.gets.to_i
  time_answer = Time.now
  if user_input == try.answers.right_answer.to_i &&
      time_answer - time_start <= try.wait_time
    puts "That's right! You got (#{try.points} points)"
    counter += 1
    score += try.points
  elsif Time.now > time_start + try.wait_time
    puts "Your time is up! Right answer: #{try.answers.right_answer}"
  else
    puts "Wrong. Right answer: #{try.answers.right_answer}"
  end
end

puts "Right answers: #{counter} from 5"
puts "You got #{score} points"

