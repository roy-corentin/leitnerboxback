class Api::LeitnerBoxes::CreateDefault < ApiAction
  post "/leitner_boxes/default_box" do
    leitner_box = SaveDefaultLeitnerBox.create!(params, user_id: current_user.id)

    json LeitnerBoxSerializer.new(leitner_box.reload), HTTP::Status::CREATED
  end
end
