class Api::LeitnerBoxes::Update < ApiAction
  put "/leitner_boxes/:leitner_box_id" do
    leitner_box = LeitnerBoxQuery.find(leitner_box_id)
    leitner_box = SaveLeitnerBox.update!(leitner_box, params, leitner_box_id: leitner_box_id.to_i, user_id: current_user.id)

    json LeitnerBoxSerializer.new(leitner_box)
  end
end
