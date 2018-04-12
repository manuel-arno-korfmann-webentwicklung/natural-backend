# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class DestroyDatabaseUserJob < ApplicationJob
  queue_as :default

  def perform(db_username)
    db_manager = ::Natural::DatabaseManager.new
    db_manager.destroy_user(db_username)
  end
end
