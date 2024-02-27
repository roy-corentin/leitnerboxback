class Api::LeitnerBoxes::Decks::Cards::Reviewed < ApiAction
  post "/leitner_boxes/:leitner_box_id/decks/:deck_id/cards/:card_id/reviewed" do
    is_correct = params.get(:is_correct) === "true"

    MoveCardAccordingToReview.run(is_correct: is_correct, leitner_box_id: leitner_box_id.to_i, deck_id: deck_id.to_i, card_id: card_id.to_i, user_id: current_user.id) do |operation|
      head HTTP::Status::NO_CONTENT
    end
  end
end
