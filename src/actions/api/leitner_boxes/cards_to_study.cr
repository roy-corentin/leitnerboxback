class Api::LeitnerBoxes::CardsToStudy < ApiAction
  get "/leitner_boxes/:leitner_box_id/next_card_to_study" do
    FetchCardsToStudy.run(user_id: current_user.id, leitner_box_id: leitner_box_id.to_i) do |operation, cards_to_study|
      if cards_to_study && cards_to_study.size > 0
        json({cards: cards_to_study.map { |card| CardSerializer.new(card) }})
      else
        json({ok: "LeitnerBox successfully studied"})
      end
    end
  end
end
