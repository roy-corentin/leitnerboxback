require "../../../spec_helper"

describe Api::LeitnerBoxes::Update do
  describe "user authenticated" do
    describe "leitner_box exist" do
      it "should return the leitner_box updated" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id).name("TestBox")

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Update.with(leitner_box.id), leitner_box: valid_params())
        response.should send_json(200, name: "NewName")
      end
    end
    describe "leitner_box does not exist" do
      it "fails to fetch the leitner_box" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Update.with(2), leitner_box: valid_params)
        response.status_code.should eq(404)
      end
    end
    describe "leitner_box does not belongs to current user" do
      it "fails to update the leitner_box" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Update.with(leitner_box.id), leitner_box: valid_params)
        response.status_code.should eq(400)
      end
    end
  end
end

private def valid_params
  {
    name: "NewName",
  }
end
