class DeckQuery < Deck::BaseQuery
  def upper_deck?(leitner_box_id, start_level)
    self.leitner_box_id(leitner_box_id).level.gt(start_level).first?
  end

  def lower_deck?(leitner_box_id, start_level)
    decks_level_desc_order = self.level.desc_order
    decks_level_desc_order.leitner_box_id(leitner_box_id).level.lt(start_level).first?
  end
end
