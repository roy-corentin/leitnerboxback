class Api::LeitnerBoxes::Cards::Show < ApiAction
  get "/leitner_boxes/:leitner_box_id/cards" do
    cards = LeitnerBoxQuery.new.cards(leitner_box_id)
    json({cards: cards.map { |card| CardSerializer.new(card) }})
  end
end
