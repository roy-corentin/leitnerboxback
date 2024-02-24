class SaveDeck < Deck::SaveOperation
  include ValidateObjectBelongsToUser

  param_key :deck

  attribute user_id : Int64
  attribute deck_id : Int64

  permit_columns leitner_box_id, period_unit, period_type, level

  before_save do
    validate_required leitner_box_id
    validate_required user_id
  end

  before_save validate_leitner_box_id_belongs_to_user
  before_save validate_deck_id_belongs_to_leitner_box

  before_save set_default_level
  before_save validate_unique_level_in_box

  def validate_unique_level_in_box
    if DeckQuery.new.leitner_box_id(leitner_box_id.value.not_nil!).level(level.value.not_nil!).first?
      level.add_error "already exists"
    end
  end

  def set_default_level
    level.value ||= (DeckQuery.new.level.select_max || 0) + 1
  end
end
