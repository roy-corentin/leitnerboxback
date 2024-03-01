class SaveDeck < Deck::SaveOperation
  include ValidateObjectBelongsToUser

  param_key :deck

  attribute user_id : Int64
  attribute deck_id : Int64

  permit_columns leitner_box_id, period_unit, period_type, level

  before_save do
    validate_required leitner_box_id
    validate_required user_id

    validate_leitner_box_id_belongs_to_user
    validate_deck_id_belongs_to_leitner_box

    set_default_level
    validate_unique_level_in_box
  end

  def set_default_level
    level.value ||= (DeckQuery.new.leitner_box_id(leitner_box_id.value.not_nil!).level.select_max || 0) + 1
  end

  def validate_unique_level_in_box
    if deck = DeckQuery.new.leitner_box_id(leitner_box_id.value.not_nil!).level(level.value.not_nil!).first?
      return unless deck.id == deck_id.value

      level.add_error "already exists"
    end
  end
end
