require "../../../spec_helper"

describe Api::Decks::Update do
  describe "user authenticated" do
    describe "deck exist" do
      it "should return the deck updated" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id).level(0)

        response = ApiClient.auth(user).exec(Api::Decks::Update.with(leitner_box.id, deck.id), deck: valid_params)
        response.should send_json(200, level: 2)
      end
    end

    describe "deck does not exist" do
      it "fails to update the deck" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::Decks::Update.with(100, 2), deck: valid_params)
        response.status_code.should eq(404)
      end
    end

    describe "deck does not belongs to current user" do
      it "fails to update the deck" do
        user = UserFactory.create
        deck = DeckFactory.create

        response = ApiClient.auth(user).exec(Api::Decks::Update.with(100, deck.id), deck: valid_params)
        response.status_code.should eq(404)
      end
    end
  end
end

private def valid_params
  {
    level: 2,
  }
end
