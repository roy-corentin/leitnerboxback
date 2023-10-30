class Card < BaseModel
  struct Content
    include JSON::Serializable

    property? front : String
    property? back : String
    property? description : String
  end

  table do
    belongs_to deck : Deck

    column card_type : String
    column content : Card::Content, serialize: true
  end
end
