class DeleteRowJob < ApplicationJob
  queue_as :default

  def perform(db_uuid, table_name, id)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(db_uuid)
    table = db.table(table_name)
    if id.present?
      table.delete_row(id)
    end
  end
end
