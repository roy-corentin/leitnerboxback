class Api::Cards::Update < ApiAction
  put "/leitner_boxes/:leitner_box_id/decks/:deck_id/cards/:card_id" do
    card = CardQuery.new.card_from_user(card_id, current_user.id)
    card = SaveCard.update!(
      card,
      params,
      leitner_box_id: leitner_box_id.to_i,
      deck_id: deck_id.to_i,
      card_id: card_id.to_i,
      user_id: current_user.id
    )

    json CardSerializer.new(card)
  end
end
