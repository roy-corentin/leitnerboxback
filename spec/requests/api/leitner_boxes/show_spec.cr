require "../../../spec_helper"

describe Api::LeitnerBoxes::Show do
  describe "user authenticated" do
    describe "leitner_box exist" do
      it "should return the existing leitner_box" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id).name("TestBox")

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Show.with(leitner_box.id))
        response.should send_json(200, name: "TestBox")
      end
    end
    describe "leitner_box does not exist" do
      it "fails to fetch the box" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Show.with(2))
        response.status_code.should eq(404)
      end
    end
    describe "leitner_box does not belongs to current user" do
      it "fails to fetch the box" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Show.with(leitner_box.id))
        response.status_code.should eq(404)
      end
    end
  end
end
