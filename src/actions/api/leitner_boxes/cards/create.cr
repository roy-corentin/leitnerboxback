class Api::LeitnerBoxes::Cards::Create < ApiAction
  post "/leitner_boxes/:leitner_box_id/cards" do
    card = SaveCard.create!(
      params,
      leitner_box_id: leitner_box_id.to_i,
      user_id: current_user.id
    )

    json CardSerializer.new(card), HTTP::Status::CREATED
  end
end
