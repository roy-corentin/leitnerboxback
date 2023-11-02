class Api::Decks::Create < ApiAction
  post "/create_deck" do
    deck = SaveDeck.create!(params, user_id: current_user.id)
    json DeckSerializer.new(deck)
  end
end
