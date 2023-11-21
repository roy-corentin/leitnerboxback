class UserSerializer < BaseSerializer
  def initialize(@user : User)
  end

  def render
    user_boxes = LeitnerBoxQuery.new.user_id(@user.id)
    {email: @user.email, leitner_box: user_boxes.map { |box| LeitnerBoxSerializer.new(box).render }}
  end
end
