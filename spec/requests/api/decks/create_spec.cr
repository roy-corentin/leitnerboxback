require "../../../spec_helper"

describe Api::Decks::Create do
  describe "user authenticated" do
    describe "with valid params" do
      it "returns the deck created" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id)
        response = ApiClient.auth(user).exec(Api::Decks::Create.with(leitner_box.id), deck: valid_params)

        response.should send_json(201, leitner_box_id: leitner_box.id, period_unit: 1, period_type: Deck::Period::Week)
      end
    end

    describe "when leitner_box doesn't exist" do
      it "fails to create the deck" do
        user = UserFactory.create
        response = ApiClient.auth(user).exec(Api::Decks::Create.with(100), deck: valid_params)

        response.should send_json(400, message: "Invalid params", details: "leitner_box_id doesn't exist")
      end
    end

    describe "when leitner_box does not belong to user" do
      it "fails to create the deck" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create
        response = ApiClient.auth(user).exec(Api::Decks::Create.with(leitner_box.id), deck: valid_params)

        response.should send_json(400, message: "Invalid params", details: "leitner_box_id does not belong to the current user")
      end
    end
  end

  describe "user not authenticated" do
    it "fails to create deck" do
      leitner_box = LeitnerBoxFactory.create
      response = ApiClient.exec(Api::Decks::Create.with(leitner_box.id), deck: valid_params)

      response.status_code.should eq(401)
    end
  end
end

private def valid_params
  {
    period_unit: 1,
    period_type: Deck::Period::Week,
  }
end
