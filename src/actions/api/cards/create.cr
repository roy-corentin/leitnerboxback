class Api::Cards::Create < ApiAction
  post "/cards" do
    card = SaveCard.create!(params, user_id: current_user.id)

    json CardSerializer.new(card), HTTP::Status::CREATED
  end
end
