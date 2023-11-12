class SaveDeck < Deck::SaveOperation
  include ValidateObjectBelongsToUser

  param_key :deck

  attribute user_id : Int64
  attribute deck_id : Int64

  permit_columns leitner_box_id, period_unit, period_type, level

  before_save validate_leitner_box_id_belongs_to_user
  before_save validate_deck_id_belongs_to_leitner_box
end
