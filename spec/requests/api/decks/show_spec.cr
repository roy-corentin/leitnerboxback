require "../../../spec_helper"

describe Api::Decks::Show do
  describe "user authenticated" do
    describe "deck exist" do
      it "should return the existing deck" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id)

        response = ApiClient.auth(user).exec(Api::Decks::Show.with(deck.id))
        response.should send_json(200, id: deck.id)
      end
    end

    describe "deck does not exist" do
      it "fails to get the deck" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::Decks::Show.with(2))
        response.status_code.should eq(404)
      end
    end

    describe "deck does not belongs to current user" do
      it "fails to get the deck" do
        user = UserFactory.create
        deck = DeckFactory.create

        response = ApiClient.auth(user).exec(Api::Decks::Show.with(deck.id))
        response.status_code.should eq(404)
      end
    end
  end
end
