class Api::SignUps::Create < ApiAction
  include Api::Auth::SkipRequireAuthToken

  post "/sign_ups" do
    user = SignUpUser.create!(params)
    json({token: UserToken.generate(user)})
  end
end
