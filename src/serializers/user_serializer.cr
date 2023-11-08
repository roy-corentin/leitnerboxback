class UserSerializer < BaseSerializer
  def initialize(@user : User)
  end

  def render
    user_boxes = LeitnerBoxQuery.new.user_id(@user.id)
    {email: @user.email, leitner_box_ids: user_boxes.map(&.id)}
  end
end
