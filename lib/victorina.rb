class Victorina
  attr_reader :questions
  attr_accessor :score, :counter
  def initialize(questions = [])
    @questions = questions
    @score = 0
    @counter = 0
  end

  def size
    @questions.size
  end

  def result
    <<~RESULT
      You got #{@score} points!
      You answered #{counter} from #{size}!
    RESULT
  end

  def counter
    @counter += 1
  end

  def score(points)
    @score += points
  end

end

