require "../../../../spec_helper"

describe Api::LeitnerBoxes::Cards::Show do
  describe "user authenticated" do
    describe "cards exist" do
      it "should return the existing card" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id)
        card1 = CardFactory.create &.deck_id(deck.id)
        card2 = CardFactory.create &.deck_id(deck.id)
        card3 = CardFactory.create &.deck_id(deck.id)

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Cards::Show.with(leitner_box.id))
        response.status_code.should eq(200)
      end
    end

    describe "card does not exist" do
      it "fails to fetch the card" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Decks::Cards::Show.with(100, 100, 2))
        response.status_code.should eq(404)
      end
    end
  end
end
