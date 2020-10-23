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

game_set = []

doc.elements.each('questions/question') do |item|
  right_answer = ''
  item.elements.each('./variants/variant/') { |variant| right_answer = variant.text if variant.attributes['right'] }
  game_set << Question.new(
    item.elements['text'].text,
    right_answer,
    item.attributes['points'],
    item.elements['variants'].elements.map(&:text),
    item.attributes['minutes']
    )
end

puts "Let's play..please answer my questions:"

counter = 0
score = 0

game_set.sample(5).each do |try|
  time_start = Time.now
  puts "#{try.question_text} (You have 5 sec for answer)"
  "#{try.list_variants.each {|variant| puts variant}}"
  user_input = STDIN.gets.chomp
  if user_input == try.correct_answer && time_answer - time_start <= try.due_time
    puts "That's right! You got (#{try.score} points)"
    counter += 1
    score += try.score
  elsif Time.now > time_start + try.due_time
    puts "Your time is up! Right answer: #{try.correct_answer}"
  else
    puts "Wrong. Right answer: #{try.correct_answer}"
  end
end

puts "Right answers: #{counter} from 5"
puts "You got #{score} points"
