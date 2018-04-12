class CreateColumnJob < ApplicationJob
  queue_as :default

  def perform(column)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(column.table.database.database_identifier)
    table = db.table(column.table.name)
    table.add_column(column.name)
  end
end
