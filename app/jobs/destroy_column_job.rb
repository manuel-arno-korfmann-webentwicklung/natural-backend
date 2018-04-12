class DestroyColumnJob < ApplicationJob
  queue_as :default

  def perform(db_uuid, table_name, column_name)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(db_uuid)
    table = db.table(table_name)
    table.destroy_column(column_name)
  end
end
