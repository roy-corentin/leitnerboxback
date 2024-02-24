require "../../../../spec_helper"

describe Api::LeitnerBoxes::Cards::Create do
  describe "user authenticated" do
    describe "with valid params" do
      it "returns the card created without deck specified" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id)
        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Cards::Create.with(leitner_box.id), card: valid_params)

        response.should send_json(201, **valid_params, deck_id: deck.id)
      end
    end

    describe "with leitner_box doesn't belong to user" do
      it "fails to create card" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create
        deck = DeckFactory.create &.leitner_box_id(leitner_box.id)
        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Decks::Cards::Create.with(leitner_box.id, deck.id), card: valid_params)

        response.should send_json(400)
      end
    end
  end

  describe "user not authenticated" do
    it "fails to create card" do
      response = ApiClient.exec(Api::LeitnerBoxes::Decks::Cards::Create.with(100, 100), card: valid_params)

      response.status_code.should eq(401)
    end
  end
end

private def valid_params
  {
    card_type: Card::Type::Text,
    content:   {front: "Eiffel Tower", back: "330 meter", description: "Test"},
  }
end
