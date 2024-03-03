require "../../../spec_helper"

describe Api::LeitnerBoxes::CardsToStudy do
  describe "user authenticated" do
    describe "with cards to study" do
      describe "with last_review_at set to nil" do
        it "returns the card to study" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck = DeckFactory.create &.leitner_box_id(leitner_box.id).period_unit(2).period_type(Deck::Period::Week)
          card = CardFactory.create &.deck_id(deck.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::CardsToStudy.with(leitner_box.id))
          response_json = JSON.parse(response.body)

          response.should send_json(200)
          response_json["cards"].size.should eq(1)
          response_json["cards"][0]["id"].should eq(card.id)
        end
      end

      describe "with last_review_at set above period" do
        it "returns the cards to study" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck = DeckFactory.create &.leitner_box_id(leitner_box.id).period_unit(2).period_type(Deck::Period::Week)
          card = CardFactory.create &.deck_id(deck.id).last_review_at(Time.utc - 2.week)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::CardsToStudy.with(leitner_box.id))
          response_json = JSON.parse(response.body)

          response.should send_json(200)
          response_json["cards"].size.should eq(1)
          response_json["cards"][0]["id"].should eq(card.id)
        end
      end

      describe "with complex case" do
        it "returns the cards to study" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck = DeckFactory.create &.leitner_box_id(leitner_box.id).period_unit(2).period_type(Deck::Period::Week)
          card1 = CardFactory.create &.deck_id(deck.id).last_review_at(Time.utc - 1.week)
          card2 = CardFactory.create &.deck_id(deck.id).last_review_at(Time.utc - 3.week)
          card3 = CardFactory.create &.deck_id(deck.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::CardsToStudy.with(leitner_box.id))
          response_json = JSON.parse(response.body)

          response.should send_json(200)
          response_json["cards"].size.should eq(2)
          response_json["cards"][0]["id"].should eq(card2.id)
          response_json["cards"][1]["id"].should eq(card3.id)
        end
      end
    end

    describe "with no cards to study" do
      it "returns ok" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id).period_unit(2).period_type(Deck::Period::Week)
        card = CardFactory.create &.deck_id(deck.id).last_review_at(Time.utc)

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::CardsToStudy.with(leitner_box.id))

        response.should send_json(200, ok: "LeitnerBox successfully studied")
      end
    end
  end
end
