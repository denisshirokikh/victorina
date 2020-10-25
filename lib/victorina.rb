class Victorina
  attr_reader :text, :right_answer, :points, :wait_time, :answers
  def initialize(text, right_answer, points, wait_time, answers = [] )
    @text = text
    @right_answer = right_answer
    @points = points.to_i
    @wait_time = wait_time.to_i
    @answers = answers
  end

  def correct_answer? (user_input)
    user_input == @right_answer.to_i
  end

  def ask_question
    "#{@text} (You have #{@wait_time} sec for answer)"
  end
end

