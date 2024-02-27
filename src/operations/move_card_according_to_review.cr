class MoveCardAccordingToReview < Avram::Operation
  include ValidateObjectBelongsToUser

  attribute is_correct : Bool
  attribute user_id : Int64
  attribute leitner_box_id : Int32
  attribute deck_id : Int32
  attribute card_id : Int32

  before_run do
    validate_required user_id
    validate_required leitner_box_id
    validate_required deck_id
    validate_required card_id
  end

  def run
    if is_correct.value
      move_card_to_upper_deck
    else
      move_card_to_first_deck
    end
  end

  def move_card_to_upper_deck
    card = CardQuery.find(card_id.value.not_nil!)
    deck = DeckQuery.find(deck_id.value.not_nil!)
    upper_deck = DeckQuery.new.upper_deck?(leitner_box_id.value.not_nil!, deck.level)
    if upper_deck
      SaveCard.update!(card, deck_id: upper_deck.id, leitner_box_id: upper_deck.leitner_box_id, user_id: user_id.value.not_nil!)
    end
  end

  def move_card_to_first_deck
    card = CardQuery.find(card_id.value.not_nil!)
    deck = DeckQuery.find(deck_id.value.not_nil!)
    first_deck = DeckQuery.new.first_deck(leitner_box_id.value.not_nil!)
    if first_deck
      SaveCard.update!(card, deck_id: first_deck.id, leitner_box_id: first_deck.leitner_box_id, user_id: user_id.value.not_nil!)
    end
  end

  before_run validate_leitner_box_id_belongs_to_user
  before_run validate_deck_id_belongs_to_leitner_box
  before_run validate_card_id_belongs_to_deck
end
