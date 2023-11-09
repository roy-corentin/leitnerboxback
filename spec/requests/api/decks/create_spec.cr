require "../../../spec_helper"

describe Api::Decks::Create do
  describe "user authenticated" do
    describe "with valid params" do
      it "returns the deck created" do
        user = UserFactory.create
        box = LeitnerBoxFactory.create &.user_id(user.id)
        response = ApiClient.auth(user).exec(Api::Decks::Create, deck: valid_params(box.id))

        response.should send_json(200, box_id: box.id, period_unit: 1, period_type: Deck::Period::Week)
      end
    end
    describe "when box doesn't exist" do
      it "fails to create the deck" do
        user = UserFactory.create
        response = ApiClient.auth(user).exec(Api::Decks::Create, deck: invalid_params())

        response.should send_json(400, message: "Invalid params", details: "box_id doesn't exist")
      end
    end

    describe "when box does not belong to user" do
      it "fails to create the deck" do
        user = UserFactory.create
        box = LeitnerBoxFactory.create
        response = ApiClient.auth(user).exec(Api::Decks::Create, deck: invalid_params(box.id))

        response.should send_json(400, message: "Invalid params", details: "box_id does not belong to the current user")
      end
    end
  end

  describe "user not authenticated" do
    it "fails to create deck" do
      box = LeitnerBoxFactory.create
      response = ApiClient.exec(Api::Decks::Create, deck: valid_params(box.id))

      response.status_code.should eq(401)
    end
  end
end

private def valid_params(box_id : Int64)
  {
    box_id:      box_id,
    period_unit: 1,
    period_type: Deck::Period::Week,
  }
end

private def invalid_params(box_id : Int64 = 100)
  {
    box_id:      box_id,
    period_unit: 1,
    period_type: Deck::Period::Week.value,
  }
end
