class Question
  def initialize(text, answer, points, variants=[], waiting_time)
    @text = text
    @answer = answer
    @points = points.to_i
    @variants = variants
    @waiting_time = waiting_time.to_i
  end

  def question_text
    @text
  end

  def correct_answer
    @answer
  end

  def score
    @points
  end

  def due_time
    @waiting_time
  end

  def list_variants
    @variants
  end
end
