class CreateDatabaseJob < ApplicationJob
  queue_as :default

  def perform(database)
    db_manager = ::Natural::DatabaseManager.new
    db_user = db_manager.database_user(database.project.db_username,
                                       database.project.db_password)
    db = db_manager.create_database(database.database_identifier)
    db_user.grant(db)
  end
end
