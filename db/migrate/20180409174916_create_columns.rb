# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class CreateColumns < ActiveRecord::Migration[5.1]
  def change
    create_table :columns do |t|
      t.string :name
      t.string :type
      t.references :table, foreign_key: true

      t.timestamps
    end
  end
end
