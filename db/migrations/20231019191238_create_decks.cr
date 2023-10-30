class CreateDecks::V20231019191238 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Deck) do
      primary_key id : Int64
      add_timestamps
      add_belongs_to box : LeitnerBox, on_delete: :nullify
      add period_unit : Int32
      add period_type : String
    end
  end

  def rollback
    drop table_for(Deck)
  end
end