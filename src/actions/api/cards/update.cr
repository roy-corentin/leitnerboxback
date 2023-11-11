class Api::Cards::Update < ApiAction
  put "/cards/:card_id" do
    card = CardQuery.new.card_from_user(card_id, current_user.id)
    card = SaveCard.update!(card, params, user_id: current_user.id)

    json CardSerializer.new(card)
  end
end
