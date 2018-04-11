class CreateTableJob < ApplicationJob
  queue_as :default

  def perform(table)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(table.database.database_identifier)
    db.create_table(table.name)
  end
end
