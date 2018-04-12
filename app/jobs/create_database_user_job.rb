class CreateDatabaseUserJob < ApplicationJob
  queue_as :default

  def perform(db_username, db_password)
    db_manager = ::Natural::DatabaseManager.new
    db_manager.create_user(db_username, db_password)
  end
end
