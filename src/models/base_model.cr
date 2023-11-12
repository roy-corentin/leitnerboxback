abstract class BaseModel < Avram::Model
  # TODO activate when it's time
  # macro default_columns
  #   primary_key id : UUID
  #   timestamps
  # end

  def self.database : Avram::Database.class
    AppDatabase
  end
end
