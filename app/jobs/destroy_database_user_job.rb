class DestroyDatabaseUserJob < ApplicationJob
  queue_as :default

  def perform(db_username)
    db_manager = ::Natural::DatabaseManager.new
    db_manager.destroy_user(db_username)
  end
end
