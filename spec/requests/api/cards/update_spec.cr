require "../../../spec_helper"

describe Api::Cards::Update do
  describe "user authenticated" do
    describe "card exist" do
      it "should return the card updated" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id)
        card = CardFactory.create &.deck_id(deck.id)

        response = ApiClient.auth(user).exec(Api::Cards::Update.with(leitner_box.id, deck.id, card.id), card: valid_params)
        response.should send_json(200, content: {front: "newFront"})
      end
    end

    describe "card does not exist" do
      it "fails to fetch the card" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::Cards::Update.with(100, 100, 2), card: valid_params)
        response.status_code.should eq(404)
      end
    end

    describe "card does not belongs to current user" do
      it "fails to update the card" do
        user = UserFactory.create
        card = CardFactory.create

        response = ApiClient.auth(user).exec(Api::Cards::Update.with(100, 100, card.id), card: valid_params)
        response.status_code.should eq(400)
      end
    end
  end
end

private def valid_params
  {
    content: {front: "newFront"},
  }
end
