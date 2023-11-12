class SaveLeitnerBox < LeitnerBox::SaveOperation
  include ValidateObjectBelongsToUser

  param_key :leitner_box

  attribute leitner_box_id : Int64

  permit_columns name, user_id

  before_save validate_leitner_box_id_belongs_to_user
end
