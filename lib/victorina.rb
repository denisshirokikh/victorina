class Victorina
  attr_reader :questions, :points, :right_answers

  def initialize(questions = [])
    @questions = questions
    @right_answers = 0
    @points = 0
  end

  def size
    @questions.size
  end

  def result
    <<~RESULT
      You got #{@points} points!
      You answered #{@right_answers} from #{size}!
    RESULT
  end

  def admit_points_and_right_answers(points, right_answers)
    @points += points
    @right_answers += 1
  end

end
