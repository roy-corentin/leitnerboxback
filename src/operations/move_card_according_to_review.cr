class MoveCardAccordingToReview < Avram::Operation
  include ValidateObjectBelongsToUser

  attribute result : Bool
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
    if result.value
      move_card_to_upper_deck
    else
      move_card_to_lower_deck
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

  def move_card_to_lower_deck
    card = CardQuery.find(card_id.value.not_nil!)
    deck = DeckQuery.find(deck_id.value.not_nil!)
    lower_deck = DeckQuery.new.lower_deck?(leitner_box_id.value.not_nil!, deck.level)
    if lower_deck
      SaveCard.update!(card, deck_id: lower_deck.id, leitner_box_id: lower_deck.leitner_box_id, user_id: user_id.value.not_nil!)
    end
  end

  before_run validate_leitner_box_id_belongs_to_user
  before_run validate_deck_id_belongs_to_leitner_box
  before_run validate_card_id_belongs_to_deck
end
