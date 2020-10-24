class Question
  attr_reader :text, :points, :wait_time, :answers
  def initialize(text, points, wait_time, answers = [] )
    @text = text
    @points = points.to_i
    @wait_time = wait_time.to_i
    @answers = answers
  end
end
