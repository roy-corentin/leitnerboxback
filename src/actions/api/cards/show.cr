class Api::Cards::Show < ApiAction
  get "/cards/:card_id" do
    card = CardQuery.new.card_from_user(card_id, current_user.id)
    json CardSerializer.new(card)
  end
end
