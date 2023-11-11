class Api::Cards::Delete < ApiAction
  delete "/cards/:card_id" do
    card = CardQuery.new.card_from_user(card_id, current_user.id)
    DeleteCard.delete!(card)

    json({ok: "Card successfully deleted"})
  end
end
