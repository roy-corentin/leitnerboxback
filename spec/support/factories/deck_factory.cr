class DeckFactory < Avram::Factory
  def initialize
    leitner_box_id LeitnerBoxFactory.create.id
    period_unit 1
    period_type Deck::Period::Week
    level (DeckQuery.new.level.select_max || 0) + 1 # TODO maybe remove
    last_review_at nil
  end
end
