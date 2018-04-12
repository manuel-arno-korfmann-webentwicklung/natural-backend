class DeleteValueJob < ApplicationJob
  queue_as :default

  def perform(db_uuid, table_name, column_name, id)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(db_uuid)
    table = db.table(table_name)
    table.delete_value(column_name, id)
  end
end
