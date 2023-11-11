class SaveDeck < Deck::SaveOperation
  include ValidateObjectBelongsToUser
  param_key :deck

  attribute user_id : Int64
  permit_columns leitner_box_id, period_unit, period_type

  before_save validate_box_belongs_to_user
end
