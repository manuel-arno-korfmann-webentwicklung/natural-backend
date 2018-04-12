# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class DestroyTableJob < ApplicationJob
  queue_as :default

  def perform(db_uuid, table_name)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(db_uuid)
    db.destroy_table(table_name)
  end
end
