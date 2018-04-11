class DestroyDatabaseJob < ApplicationJob
  queue_as :default

  def perform(db_uuid)
    db_manager = ::Natural::DatabaseManager.new
    db_manager.destroy_database(db_uuid)
  end
end
