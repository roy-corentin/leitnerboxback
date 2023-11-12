module ValidateObjectBelongsToUser
  private def validate_leitner_box_id_belongs_to_user
    leitner_box_id.value.try do |value|
      leitner_box = LeitnerBoxQuery.new.id(value).first?

      if (!leitner_box)
        leitner_box_id.add_error "doesn't exist"
      elsif (leitner_box.user_id != user_id.value)
        leitner_box_id.add_error "does not belong to the current user"
      end
    end
  end

  private def validate_deck_id_belongs_to_leitner_box
    deck_id.value.try do |value|
      deck = DeckQuery.new.id(value).first?

      if (!deck)
        deck_id.add_error "doesn't exist"
      elsif (deck.leitner_box_id != leitner_box_id.value)
        deck_id.add_error "does not belong to this leitner_box"
      end
    end
  end

  private def validate_card_id_belongs_to_deck
    card_id.value.try do |value|
      card = CardQuery.new.id(value).first?

      if (!card)
        card_id.add_error "doesn't exist"
      elsif (card.deck_id != deck_id.value)
        card_id.add_error "does not belong to this deck"
      end
    end
  end
end
