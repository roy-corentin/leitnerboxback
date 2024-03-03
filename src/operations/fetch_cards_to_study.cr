class FetchCardsToStudy < Avram::Operation
  include ValidateObjectBelongsToUser

  attribute user_id : Int64
  attribute leitner_box_id : Int32

  before_run do
    validate_required leitner_box_id
    validate_leitner_box_id_belongs_to_user
  end

  def run : Array(Card)
    leitner_box = LeitnerBoxQuery.find(leitner_box_id.value.not_nil!)
    decks_to_check = DeckQuery.new.leitner_box_id(leitner_box.id).level.asc_order
    decks_to_check.flat_map(&.cards_to_study)
  end
end
