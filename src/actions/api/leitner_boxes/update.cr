class Api::LeitnerBoxes::Update < ApiAction
  put "/leitner_boxes/:leitner_box_id" do
    leitner_box = LeitnerBoxQuery.new.id(leitner_box_id).user_id(current_user.id).first
    leitner_box = SaveLeitnerBox.update!(leitner_box, params)

    json LeitnerBoxSerializer.new(leitner_box)
  end
end
