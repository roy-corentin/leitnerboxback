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
    column last_review_at : Time?
  end

  def next_card_to_study?
    return nil unless self.need_review?

    current_date = Time.utc
    CardQuery.new.deck_id(self.id).each do |card|
      if card.last_review_at.nil? || card.last_review_at.not_nil! + period < current_date
        return card
      end
    end

    nil
  end

  def need_review?
    return true if last_review_at.nil?

    # TODO remove 'not_nil!' when Crystal compile-time type check fixed
    next_review_date = last_review_at.not_nil! + period
    current_date = Time.utc

    return next_review_date < current_date
  end

  private def period
    case period_type
    when Period::Week
      period_unit.week
    when Period::Month
      period_unit.month
    when Period::Year
      period_unit.year
    else
      0.week
    end
  end
end
