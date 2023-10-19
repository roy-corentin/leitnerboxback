class Box < BaseModel
  table do
    column name : String

    belongs_to user : User
  end
end
