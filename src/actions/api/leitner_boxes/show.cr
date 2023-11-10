class Api::LeitnerBoxes::Show < ApiAction
  post "/leitner_boxes/:leitner_box_id" do
    leitner_box = LeitnerBoxQuery.new.id(leitner_box_id).user_id(current_user.id).first
    json LeitnerBoxSerializer.new(leitner_box)
  end
end
