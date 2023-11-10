class Api::Decks::Show < ApiAction
  get "/decks/:deck_id" do
    deck = DeckQuery.new.id(deck_id).where_leitner_box(LeitnerBoxQuery.new.user_id(current_user.id)).first
    json DeckSerializer.new(deck)
  end
end
