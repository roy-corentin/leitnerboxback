class LeitnerBoxSerializer < BaseSerializer
  def initialize(@leitner_box : LeitnerBox)
  end

  def render
    card_ids = LeitnerBoxQuery.new.card_ids(@leitner_box.id)
    {id: @leitner_box.id, name: @leitner_box.name, user_id: @leitner_box.user_id, cards_id: card_ids}
  end
end
