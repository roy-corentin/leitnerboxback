module ValidateObjectBelongsToUser
  private def validate_box_belongs_to_user
    leitner_box_id.value.try do |value|
      leitner_box = LeitnerBoxQuery.new.id(value).first?

      if (!leitner_box)
        leitner_box_id.add_error "doesn't exist"
      elsif (leitner_box.user_id != user_id.value)
        leitner_box_id.add_error "does not belong to the current user"
      end
    end
  end

  private def validate_deck_belongs_to_user
    deck_id.value.try do |value|
      deck = DeckQuery.new.id(value).first?

      if (!deck)
        deck_id.add_error "doesn't exist"
        return nil
      end

      leitner_box = LeitnerBoxQuery.new.id(deck.leitner_box_id).first?

      if (!leitner_box)
        deck_id.add_error "leitner_box doesn't exist"
      elsif (leitner_box.user_id != user_id.value)
        deck_id.add_error "leitner_box does not belong to the current user"
      end
    end
  end
end
