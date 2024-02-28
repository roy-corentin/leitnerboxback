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

    validate_leitner_box_id_belongs_to_user
    validate_deck_id_belongs_to_leitner_box
    validate_card_id_belongs_to_deck
  end

  def run
    if is_correct.value
      move_card_to_upper_deck
    else
      move_card_to_first_deck
    end
  end

  # TODO remove not_nil! when lucky check 'validate_required'
  private def move_card_to_upper_deck
    card = CardQuery.find(card_id.value.not_nil!)
    deck = DeckQuery.find(deck_id.value.not_nil!)

    if upper_deck = DeckQuery.new.upper_deck?(leitner_box_id.value.not_nil!, deck.level)
      SaveCard.update!(card, card_id: card.id, deck_id: upper_deck.id, leitner_box_id: leitner_box_id.value.not_nil!, user_id: user_id.value.not_nil!, last_review_at: Time.utc)
    else
      SaveCard.update!(card, last_review_at: Time.utc, leitner_box_id: leitner_box_id.value.not_nil!, user_id: user_id.value.not_nil!)
    end
  end

  private def move_card_to_first_deck
    card = CardQuery.find(card_id.value.not_nil!)
    deck = DeckQuery.find(deck_id.value.not_nil!)

    if first_deck = DeckQuery.new.first_deck(leitner_box_id.value.not_nil!)
      SaveCard.update!(card, card_id: card.id, deck_id: first_deck.id, leitner_box_id: leitner_box_id.value.not_nil!, user_id: user_id.value.not_nil!, last_review_at: Time.utc)
    else
      SaveCard.update!(card, last_review_at: Time.utc, leitner_box_id: leitner_box_id.value.not_nil!, user_id: user_id.value.not_nil!)
    end
  end
end
