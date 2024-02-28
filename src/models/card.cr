class Card < BaseModel
  enum Type
    Text
    Image
    Document
  end

  struct Content
    include JSON::Serializable

    property front : String?
    property back : String?
    property description : String?
  end

  table do
    belongs_to deck : Deck

    column card_type : Card::Type
    column content : Card::Content, serialize: true
    column last_review_at : Time?
  end
end
