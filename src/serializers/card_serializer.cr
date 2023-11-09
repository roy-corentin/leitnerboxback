class CardSerializer < BaseSerializer
  def initialize(@card : Card)
  end

  def render
    {id: @card.id, deck_id: @card.deck_id, card_type: @card.card_type}
  end
end
