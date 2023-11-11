class CardSerializer < BaseSerializer
  def initialize(@card : Card)
  end

  def render
    {
      id:          @card.id,
      deck_id:     @card.deck_id,
      card_type:   @card.card_type,
      content:     @card.content,
      last_review: @card.last_review,
    }
  end
end
