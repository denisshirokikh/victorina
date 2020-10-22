class Question
  def initialize(text, answer, score)
    @text = text
    @answer = answer
    @score = score.to_i
  end

  def question_text
    return @text
  end

  def correct_answer
    return @answer
  end

  def score
    return @score
  end
end
