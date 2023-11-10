class SaveLeitnerBox < LeitnerBox::SaveOperation
  param_key :leitner_box
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/saving-records#perma-permitting-columns
  #
  permit_columns name, user_id
end
