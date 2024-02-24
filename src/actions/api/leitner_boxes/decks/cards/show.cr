class Api::LeitnerBoxes::Decks::Cards::Show < ApiAction
  get "/leitner_boxes/:leitner_box_id/decks/:deck_id/cards/:card_id" do
    card = CardQuery.new.card_from_user(card_id, current_user.id)
    json CardSerializer.new(card)
  end
end
