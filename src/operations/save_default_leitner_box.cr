class SaveDefaultLeitnerBox < LeitnerBox::SaveOperation
  param_key :leitner_box

  permit_columns name, user_id

  after_save do |leitner_box|
    SaveDeck.create!(period_unit: 7, period_type: Deck::Period::Week, user_id: leitner_box.user_id, leitner_box_id: leitner_box.id)
    SaveDeck.create!(period_unit: 3, period_type: Deck::Period::Week, user_id: leitner_box.user_id, leitner_box_id: leitner_box.id)
    SaveDeck.create!(period_unit: 1, period_type: Deck::Period::Week, user_id: leitner_box.user_id, leitner_box_id: leitner_box.id)
    SaveDeck.create!(period_unit: 2, period_type: Deck::Period::Month, user_id: leitner_box.user_id, leitner_box_id: leitner_box.id)
    SaveDeck.create!(period_unit: 1, period_type: Deck::Period::Month, user_id: leitner_box.user_id, leitner_box_id: leitner_box.id)
  end
end
