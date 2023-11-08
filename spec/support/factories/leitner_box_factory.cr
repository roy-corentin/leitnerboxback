class LeitnerBoxFactory < Avram::Factory
  def initialize
    name sequence("TestBox")
    user_id UserFactory.create.id
  end
end
