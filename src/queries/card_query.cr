class CardQuery < Card::BaseQuery
  def card_from_user(card_id, user_id)
    self.id(card_id).where_deck(DeckQuery.new.where_leitner_box(LeitnerBoxQuery.new.user_id(user_id))).first
  end
end
