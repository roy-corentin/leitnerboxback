class Api::LeitnerBoxes::Decks::Update < ApiAction
  put "/leitner_boxes/:leitner_box_id/decks/:deck_id" do
    deck = DeckQuery.find(deck_id)
    deck = SaveDeck.update!(deck, params, leitner_box_id: leitner_box_id.to_i, deck_id: deck_id.to_i, user_id: current_user.id)

    json DeckSerializer.new(deck)
  end
end
