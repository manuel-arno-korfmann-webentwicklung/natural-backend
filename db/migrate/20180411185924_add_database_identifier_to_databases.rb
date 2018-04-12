# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class AddDatabaseIdentifierToDatabases < ActiveRecord::Migration[5.1]
  def change
    add_column :databases, :database_identifier, :string
    add_index :databases, :database_identifier, unique: true
  end
end
