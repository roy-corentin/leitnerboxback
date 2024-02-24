class Api::LeitnerBoxes::Decks::Cards::Create < ApiAction
  post "/leitner_boxes/:leitner_box_id/decks/:deck_id/cards" do
    card = SaveCard.create!(
      params,
      leitner_box_id: leitner_box_id.to_i,
      deck_id: deck_id.to_i,
      user_id: current_user.id
    )

    json CardSerializer.new(card), HTTP::Status::CREATED
  end
end
