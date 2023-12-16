require "../../../spec_helper"

describe Api::Me::Show do
  it "returns the signed in user" do
    user = UserFactory.create
    leitner_box = LeitnerBoxFactory.create &.user_id(user.id).name("UserBox")

    response = ApiClient.auth(user).exec(Api::Me::Show)

    response.should send_json(
      200,
      email: user.email,
      leitner_box: [
        {
          "id"       => leitner_box.id,
          "name"     => "UserBox",
          "user_id"  => user.id,
          "cards_id" => ([] of String),
        },
      ]
    )
  end

  it "fails if not authenticated" do
    response = ApiClient.exec(Api::Me::Show)

    response.status_code.should eq(401)
  end
end
