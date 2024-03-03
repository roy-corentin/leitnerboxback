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
    column level : Int32
  end

  def cards_to_study
    current_time = Time.utc
    CardQuery.new.deck_id(self.id)
      .last_review_at.is_nil
      .or(&.last_review_at.lte(current_time - review_period))
      .to_a
  end

  private def review_period
    case period_type
    when Period::Week
      period_unit.week
    when Period::Month
      period_unit.month
    when Period::Year
      period_unit.year
    else
      raise "Unknown period type"
    end
  end
end
