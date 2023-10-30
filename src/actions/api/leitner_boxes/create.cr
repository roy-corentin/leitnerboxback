class Api::LeitnerBoxes::Create < ApiAction
  post "/create_box" do
    box_name = JSON.parse(params.get(:box))["name"].to_s
    complete_params = Avram::Params.new({"name" => box_name, "user_id" => current_user.id.to_s})
    box = SaveLeitnerBox.create!(complete_params)
    json LeitnerBoxSerializer.new(box)
  end
end
