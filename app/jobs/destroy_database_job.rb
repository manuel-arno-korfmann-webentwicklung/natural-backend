class DestroyDatabaseJob < ApplicationJob
  queue_as :default

  def perform(database)
    db_manager = ::Natural::DatabaseManager.new
    db_manager.destroy_database(database.database_identifier)
  end
end
