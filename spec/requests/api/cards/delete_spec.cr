require "../../../spec_helper"

describe Api::Cards::Delete do
  describe "user authenticated" do
    describe "card exist" do
      it "should delete the existing card" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id)
        card = CardFactory.create &.deck_id(deck.id)

        response = ApiClient.auth(user).exec(Api::Cards::Delete.with(card.id))
        response.should send_json(200, ok: "Card successfully deleted")
      end
    end

    describe "card does not exist" do
      it "fails to delete the card" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::Cards::Delete.with(2))
        response.status_code.should eq(404)
      end
    end

    describe "card does not belongs to current user" do
      it "fails to delete the card" do
        user = UserFactory.create
        card = CardFactory.create

        response = ApiClient.auth(user).exec(Api::Cards::Delete.with(card.id))
        response.status_code.should eq(404)
      end
    end
  end
end
