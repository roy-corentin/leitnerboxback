class LeitnerBox < BaseModel
  table do
    belongs_to user : User
    has_many decks : Deck
    has_many cards : Card, through: [:decks, :cards]

    column name : String
  end
end
