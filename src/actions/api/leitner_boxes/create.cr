class Api::LeitnerBoxes::Create < ApiAction
  post "/leitner_boxes" do
    leitner_box = SaveLeitnerBox.create!(params, user_id: current_user.id)

    json LeitnerBoxSerializer.new(leitner_box), HTTP::Status::CREATED
  end
end
