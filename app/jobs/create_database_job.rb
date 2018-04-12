# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

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
