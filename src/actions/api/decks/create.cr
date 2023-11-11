class Api::Decks::Create < ApiAction
  post "/decks" do
    deck = SaveDeck.create!(params, user_id: current_user.id)

    json DeckSerializer.new(deck), HTTP::Status::CREATED
  end
end
