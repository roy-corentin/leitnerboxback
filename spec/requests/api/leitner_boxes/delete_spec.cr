require "../../../spec_helper"

describe Api::LeitnerBoxes::Delete do
  describe "user authenticated" do
    describe "leitner_box exist" do
      it "should delete the existing leitner_box" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create &.user_id(user.id).name("TestBox")

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Delete.with(leitner_box.id))
        response.should send_json(200, ok: "LeitnerBox successfully deleted")
      end
    end
    describe "leitner_box does not exist" do
      it "fails to delete the box" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Delete.with(2))
        response.status_code.should eq(404)
      end
    end
    describe "leitner_box does not belongs to current user" do
      it "fails to delete the box" do
        user = UserFactory.create
        leitner_box = LeitnerBoxFactory.create

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Delete.with(leitner_box.id))
        response.status_code.should eq(404)
      end
    end
  end
end
