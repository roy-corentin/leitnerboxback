class Api::Cards::Create < ApiAction
  post "/cards" do
    card = SaveCard.create!(params)
    json CardSerializer.new(card)
  end
end
