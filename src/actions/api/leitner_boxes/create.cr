class Api::LeitnerBoxes::Create < ApiAction
  post "/boxs" do
    box = SaveLeitnerBox.create!(params, user_id: current_user.id)
    json LeitnerBoxSerializer.new(box)
  end
end
