class DeckFactory < Avram::Factory
  def initialize
    leitner_box_id LeitnerBoxFactory.create.id
    period_unit 1
    period_type Deck::Period::Week
    level 0
    last_review nil
  end
end
