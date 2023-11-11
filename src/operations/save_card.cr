class SaveCard < Card::SaveOperation
  include ValidateObjectBelongsToUser

  param_key :card

  attribute user_id : Int64
  permit_columns deck_id, card_type, content

  before_save validate_deck_belongs_to_user
end
