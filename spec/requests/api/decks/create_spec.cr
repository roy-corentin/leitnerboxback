require "../../../spec_helper"

describe Api::Decks::Create do
  describe "user authenticated" do
    describe "with valid params" do
      it "returns the deck created" do
        user = UserFactory.create
        box = LeitnerBoxFactory.create &.user_id(user.id)
        response = ApiClient.auth(user).exec(Api::Decks::Create, deck: valid_params(box))

        response.should send_json(200, box_id: box.id, period_unit: 1, period_type: "week")
      end
    end
  end

  describe "user not authenticated" do
    it "fails to create deck" do
      box = LeitnerBoxFactory.create
      response = ApiClient.exec(Api::Decks::Create, deck: valid_params(box))

      response.status_code.should eq(401)
    end
  end
end

private def valid_params(box : LeitnerBox)
  {
    box_id:      box.id,
    period_unit: 1,
    period_type: "week",
  }
end
