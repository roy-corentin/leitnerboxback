class Api::LeitnerBoxes::NextCardToStudy < ApiAction
  get "/leitner_boxes/:leitner_box_id/next_card_to_study" do
    FetchNextCardToStudy.run(user_id: current_user.id, leitner_box_id: leitner_box_id.to_i) do |operation, card_to_study|
      if card_to_study
        json CardSerializer.new(card_to_study)
      else
        json({ok: "LeitnerBox successfully studied"})
      end
    end
  end
end
