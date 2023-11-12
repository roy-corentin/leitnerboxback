class CardFactory < Avram::Factory
  def initialize
    deck_id DeckFactory.create.id
    card_type Card::Type::Text
    content Card::Content.from_json(%({"front": "test", "back": "test"}))
    last_review nil
  end
end
