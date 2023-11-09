class DeckFactory < Avram::Factory
  def initialize
    box_id LeitnerBoxFactory.create.id
    period_unit 1
    period_type Deck::Period::Week
  end
end
