class Api::LeitnerBoxes::Decks::Cards::Reviewed < ApiAction
  post "/letner_boxes/:leitner_box_id/decks/:deck_id/cards/:card_id/reviewed" do
    result = params.get(:result) === "true"

    MoveCardAccordingToReview.run(result: result, leitner_box_id: leitner_box_id.to_i, deck_id: deck_id.to_i, card_id: card_id.to_i, user_id: current_user.id) do |operation|
      head HTTP::Status::NO_CONTENT
    end
  end
end
