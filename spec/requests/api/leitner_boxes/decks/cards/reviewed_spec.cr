require "../../../../../spec_helper"

describe Api::LeitnerBoxes::Decks::Cards::Reviewed do
  describe "user authenticated" do
    describe "when card is from first deck" do
      describe "when user was right" do
        it "moves the card to the next deck" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck1 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck2 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck3 = DeckFactory.create &.leitner_box_id(leitner_box.id)

          card = CardFactory.create &.deck_id(deck1.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Decks::Cards::Reviewed.with(leitner_box.id, deck1.id, card.id), result: true)
          response.status_code.should eq(204)

          card.reload.deck_id.should eq(deck2.id)
        end
      end

      describe "when user was wrong" do
        it "leaves the card in it's deck" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck1 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck2 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck3 = DeckFactory.create &.leitner_box_id(leitner_box.id)

          card = CardFactory.create &.deck_id(deck1.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Decks::Cards::Reviewed.with(leitner_box.id, deck1.id, card.id), result: false)
          response.status_code.should eq(204)

          card.reload.deck_id.should eq(deck1.id)
        end
      end
    end

    describe "when card is from second deck" do
      describe "when user was right" do
        it "moves the card to the next deck" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck1 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck2 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck3 = DeckFactory.create &.leitner_box_id(leitner_box.id)

          card = CardFactory.create &.deck_id(deck2.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Decks::Cards::Reviewed.with(leitner_box.id, deck2.id, card.id), result: true)
          response.status_code.should eq(204)

          card.reload.deck_id.should eq(deck3.id)
        end
      end

      describe "when user was wrong" do
        it "moves the card to the lower deck" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck1 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck2 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck3 = DeckFactory.create &.leitner_box_id(leitner_box.id)

          card = CardFactory.create &.deck_id(deck2.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Decks::Cards::Reviewed.with(leitner_box.id, deck2.id, card.id), result: false)
          response.status_code.should eq(204)

          card.reload.deck_id.should eq(deck1.id)
        end
      end
    end

    describe "when card is from last deck" do
      describe "when user was right" do
        it "leaves the card in it's deck" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck1 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck2 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck3 = DeckFactory.create &.leitner_box_id(leitner_box.id)

          card = CardFactory.create &.deck_id(deck3.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Decks::Cards::Reviewed.with(leitner_box.id, deck3.id, card.id), result: true)
          response.status_code.should eq(204)

          card.reload.deck_id.should eq(deck3.id)
        end
      end

      describe "when user was wrong" do
        it "moves the card to the first deck" do
          user = UserFactory.create
          leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
          deck1 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck2 = DeckFactory.create &.leitner_box_id(leitner_box.id)
          deck3 = DeckFactory.create &.leitner_box_id(leitner_box.id)

          card = CardFactory.create &.deck_id(deck3.id)

          response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Decks::Cards::Reviewed.with(leitner_box.id, deck3.id, card.id), result: false)
          response.status_code.should eq(204)

          card.reload.deck_id.should eq(deck1.id)
        end
      end
    end
  end
end
