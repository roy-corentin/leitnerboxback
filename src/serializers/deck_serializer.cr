class DeckSerializer < BaseSerializer
  def initialize(@deck : Deck)
  end

  def render
    card_ids = CardQuery.new.deck_id(@deck.id).map(&.id)
    {id: @deck.id, box_id: @deck.box_id, period_unit: @deck.period_unit, period_type: @deck.period_type, card_ids: card_ids}
  end
end
