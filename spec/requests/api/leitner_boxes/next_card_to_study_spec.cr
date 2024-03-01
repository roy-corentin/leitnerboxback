require "../../../spec_helper"

describe Api::LeitnerBoxes::NextCardToStudy do
  describe "user authenticated" do
    describe "with cards to study" do
      describe "with last_review_at set to nil" do
        it "returns the card to study" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck = DeckFactory.create &.leitner_box_id(leitner_box.id)
          card = CardFactory.create &.deck_id(deck.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::NextCardToStudy.with(leitner_box.id))

          response.should send_json(200, id: card.id)
        end
      end

      describe "with last_review_at set above period" do
        it "returns ok" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck = DeckFactory.create &.leitner_box_id(leitner_box.id)
          card = CardFactory.create &.deck_id(deck.id).last_review_at(Time.utc - 2.week)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::NextCardToStudy.with(leitner_box.id))

          response.should send_json(200, id: card.id)
        end
      end
    end

    describe "with no cards to study" do
      it "returns ok" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id)
        card = CardFactory.create &.deck_id(deck.id).last_review_at(Time.utc)

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::NextCardToStudy.with(leitner_box.id))

        response.should send_json(200, ok: "LeitnerBox successfully studied")
        deck.reload.last_review_at.should_not be_nil
      end
    end
  end
end
