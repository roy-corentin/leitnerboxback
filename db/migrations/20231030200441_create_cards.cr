class CreateCards::V20231030200441 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Card) do
      primary_key id : Int64
      add_timestamps
      add_belongs_to deck : Deck, on_delete: :nullify
      add card_type : Int32
      add content : JSON::Any
      add last_review : Time?
    end
  end

  def rollback
    drop table_for(Card)
  end
end
