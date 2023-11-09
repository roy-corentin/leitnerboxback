class Deck < BaseModel
  enum Period
    Week
    Month
    Year
  end

  table do
    belongs_to box : LeitnerBox
    has_many cards : Card

    column period_unit : Int32
    column period_type : Deck::Period
  end
end
