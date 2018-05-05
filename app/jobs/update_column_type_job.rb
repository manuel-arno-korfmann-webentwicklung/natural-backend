class UpdateColumnTypeJob < ApplicationJob
  queue_as :default

  def perform(table, column_name, column_type)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(table.database.database_identifier)
    table = db.table(table.name)
    table.update_column_type(column_name, column_type)
  end
end
