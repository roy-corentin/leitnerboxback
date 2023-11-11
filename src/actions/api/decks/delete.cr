class Api::Decks::Delete < ApiAction
  delete "/decks/:deck_id" do
    deck = DeckQuery.new.id(deck_id).where_leitner_box(LeitnerBoxQuery.new.user_id(current_user.id)).first
    DeleteDeck.delete!(deck)

    json({ok: "Deck successfully deleted"})
  end
end
