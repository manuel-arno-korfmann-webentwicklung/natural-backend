class UpdateColumnTypeJob < ApplicationJob
  queue_as :default

  def perform(column)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(column.table.database.database_identifier)
    table = db.table(column.table.name)
    table.update_column_type(column.name, column.type)
  end
end
