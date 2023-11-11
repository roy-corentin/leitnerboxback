require "../../../spec_helper"

describe Api::LeitnerBoxes::Create do
  describe "user authenticated" do
    describe "with valid params" do
      it "returns the leitner_box created" do
        user = UserFactory.create

        response = ApiClient.auth(user).exec(Api::LeitnerBoxes::Create, leitner_box: valid_params())

        response.should send_json(201, name: "TestBox")
      end
    end
  end

  describe "user not authenticated" do
    it "fails to create leitner_box" do
      response = ApiClient.exec(Api::LeitnerBoxes::Create, leitner_box: valid_params())

      response.status_code.should eq(401)
    end
  end
end

private def valid_params
  {
    name: "TestBox",
  }
end
