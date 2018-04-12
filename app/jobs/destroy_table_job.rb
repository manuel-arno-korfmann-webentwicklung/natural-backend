class DestroyTableJob < ApplicationJob
  queue_as :default

  def perform(db_uuid, table_name)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(db_uuid)
    db.destroy_table(table_name)
  end
end
