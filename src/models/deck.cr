class Deck < BaseModel
  enum Period
    Week
    Month
    Year
  end

  table do
    belongs_to leitner_box : LeitnerBox
    has_many cards : Card

    column period_unit : Int32
    column period_type : Deck::Period
    column level : Int32 = 0
    column last_review : Time?
  end
end
