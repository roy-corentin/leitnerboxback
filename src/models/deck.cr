class Deck < BaseModel
  table do
    belongs_to box : LeitnerBox
    has_many cards : Card

    column period_unit : Int32
    column period_type : String
  end
end
