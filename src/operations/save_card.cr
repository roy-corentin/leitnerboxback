class SaveCard < Card::SaveOperation
  include ValidateObjectBelongsToUser

  param_key :card

  attribute user_id : Int64
  attribute leitner_box_id : Int64
  attribute card_id : Int64

  permit_columns deck_id, card_type, content

  before_save set_default_deck_id

  before_save do
    validate_leitner_box_id_belongs_to_user
    validate_deck_id_belongs_to_leitner_box
    validate_card_id_belongs_to_deck unless deck_id.changed?
  end

  private def set_default_deck_id
    return unless deck_id.value.nil?
    first_level_deck = DeckQuery.new.leitner_box_id(leitner_box_id.value.not_nil!).level.asc_order.first?
    if first_level_deck
      deck_id.value = first_level_deck.id
    end
  end
end
