class Api::LeitnerBoxes::Decks::Create < ApiAction
  post "/leitner_boxes/:leitner_box_id/decks" do
    deck = SaveDeck.create!(params, leitner_box_id: leitner_box_id.to_i, user_id: current_user.id)

    json DeckSerializer.new(deck), HTTP::Status::CREATED
  end
end
