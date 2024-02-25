class FetchNextCardToStudy < Avram::Operation
  include ValidateObjectBelongsToUser

  attribute user_id : Int64
  attribute leitner_box_id : Int32

  before_run validate_required leitner_box_id
  before_run validate_leitner_box_id_belongs_to_user

  def run
    # TODO remove 'not_nil!' x2
    leitner_box = LeitnerBoxQuery.find(leitner_box_id.value.not_nil!)
    decks_to_check = DeckQuery.new.leitner_box_id(leitner_box.id).level.asc_order
    decks_to_check.each do |deck|
      card_to_study = deck.next_card_to_study?
      next if card_to_study.nil?

      return card_to_study
    end
  end
end
