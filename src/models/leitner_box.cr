class LeitnerBox < BaseModel
  table do
    has_many decks : Deck

    column name : String
    belongs_to user : User
  end
end
