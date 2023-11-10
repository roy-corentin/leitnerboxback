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
  end
end
