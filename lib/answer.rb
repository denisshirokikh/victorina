class Answer
  attr_reader :right_answer, :variants

  def initialize(right_answer, variants = [])
    @right_answer = right_answer
    @variants = variants
  end

  def list
    @variants.shuffle
  end
end
