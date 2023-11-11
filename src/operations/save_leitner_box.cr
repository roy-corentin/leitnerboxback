class SaveLeitnerBox < LeitnerBox::SaveOperation
  param_key :leitner_box

  permit_columns name, user_id
end
