module ValidateObjectBelongsToUser
  private def validate_box_belongs_to_user
    box_id.value.try do |value|
      box = LeitnerBoxQuery.new.id(value).first?

      if (!box)
        box_id.add_error "doesn't exist"
      elsif (box.user_id != user_id.value)
        box_id.add_error "does not belong to the current user"
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

      box = LeitnerBoxQuery.new.id(deck.box_id).first?

      if (!box)
        deck_id.add_error "box doesn't exist"
      elsif (box.user_id != user_id.value)
        deck_id.add_error "box does not belong to the current user"
      end
    end
  end
end
