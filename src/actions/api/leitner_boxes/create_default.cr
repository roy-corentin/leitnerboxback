class Api::LeitnerBoxes::CreateDefault < ApiAction
  post "/leitner_boxes/default_box" do
    # TODO Create specifig operation and move deck creation in 'after_create' callback
    leitner_box = SaveLeitnerBox.create!(params, user_id: current_user.id)

    SaveDeck.create!(period_unit: 7, period_type: Deck::Period::Week, level: 1, user_id: current_user.id, leitner_box_id: leitner_box.id)
    SaveDeck.create!(period_unit: 3, period_type: Deck::Period::Week, level: 2, user_id: current_user.id, leitner_box_id: leitner_box.id)
    SaveDeck.create!(period_unit: 1, period_type: Deck::Period::Week, level: 3, user_id: current_user.id, leitner_box_id: leitner_box.id)
    SaveDeck.create!(period_unit: 2, period_type: Deck::Period::Month, level: 4, user_id: current_user.id, leitner_box_id: leitner_box.id)
    SaveDeck.create!(period_unit: 1, period_type: Deck::Period::Month, level: 5, user_id: current_user.id, leitner_box_id: leitner_box.id)

    json LeitnerBoxSerializer.new(leitner_box.reload), HTTP::Status::CREATED
  end
end
