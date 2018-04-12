# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class CreateColumnJob < ApplicationJob
  queue_as :default

  def perform(column)
    db_manager = ::Natural::DatabaseManager.new
    db = db_manager.database(column.table.database.database_identifier)
    table = db.table(column.table.name)
    table.add_column(column.name)
  end
end
