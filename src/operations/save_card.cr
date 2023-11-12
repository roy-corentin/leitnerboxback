class SaveCard < Card::SaveOperation
  include ValidateObjectBelongsToUser

  param_key :card

  attribute user_id : Int64
  attribute leitner_box_id : Int64
  attribute card_id : Int64

  permit_columns deck_id, card_type, content

  before_save validate_leitner_box_id_belongs_to_user
  before_save validate_deck_id_belongs_to_leitner_box
  before_save validate_card_id_belongs_to_deck
end
