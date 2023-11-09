class SaveDeck < Deck::SaveOperation
  param_key :deck
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/saving-records#perma-permitting-columns
  #
  attribute user_id : Int64
  permit_columns box_id, period_unit, period_type

  before_save validate_box

  def validate_box
    box_id.value.try do |value|
      box = LeitnerBoxQuery.new.id(value).first?

      if (!box)
        box_id.add_error "doesn't exist"
      elsif (box.user_id != user_id.value)
        box_id.add_error "does not belong to the current user"
      end
    end
  end
end
