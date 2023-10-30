class LeitnerBoxSerializer < BaseSerializer
  def initialize(@leitner_box : LeitnerBox)
  end

  def render
    {name: @leitner_box.name, user_id: @leitner_box.user_id}
  end
end
