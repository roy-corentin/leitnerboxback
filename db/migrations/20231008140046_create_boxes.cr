class CreateBoxes::V20231008140046 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Box) do
      primary_key id : Int64
      add_timestamps
      add name : String
      add_belongs_to user : User, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Box)
  end
end
