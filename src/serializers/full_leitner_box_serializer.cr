class FullLeitnerBoxSerializer < BaseSerializer
  def initialize(@leitner_box : LeitnerBox)
  end

  def render
    card_ids = LeitnerBoxQuery.new.card_ids(@leitner_box.id)
    decks = DeckQuery.new.leitner_box_id(@leitner_box.id)
    {
      id:       @leitner_box.id,
      name:     @leitner_box.name,
      user_id:  @leitner_box.user_id,
      cards_id: card_ids,
      decks:    decks.map { |deck| DeckSerializer.new(deck).render },
    }
  end
end
