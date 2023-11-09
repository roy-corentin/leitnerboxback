require "../../../spec_helper"

describe Api::Cards::Create do
  describe "user authenticated" do
    describe "with valid params" do
      it "returns the card created" do
        user = UserFactory.create
        box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.box_id(box.id)
        response = ApiClient.auth(user).exec(Api::Cards::Create, card: valid_params(deck))

        response.should send_json(200, deck_id: deck.id, card_type: Card::Type::Text)
      end
    end
  end

  describe "user not authenticated" do
    it "fails to create card" do
      deck = DeckFactory.create
      response = ApiClient.exec(Api::Cards::Create, card: valid_params(deck))

      response.status_code.should eq(401)
    end
  end
end

private def valid_params(deck : Deck)
  {
    deck_id:   deck.id,
    card_type: Card::Type::Text,
    content:   {front: "Eiffel Tower", back: "330 meter", description: "Test"},
    # content:   %({}),
  }
end
