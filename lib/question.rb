class Question
  attr_reader :text, :right_answer, :points, :wait_time, :answers

  def initialize(text, right_answer, points, wait_time, answers)
    @text = text
    @right_answer = right_answer
    @points = points.to_i
    @wait_time = wait_time.to_i
    @answers = answers
  end

  def correct_answer?(user_input)
    user_input == @right_answer
  end

  def to_s
    <<~TO_S
      #{@text} (You have #{@wait_time} sec for answer)
      #{print_answers}
    TO_S
  end

  private
  def print_answers
    @answers.map { |answer| " #{answer}" }.join("\n")
  end
end
