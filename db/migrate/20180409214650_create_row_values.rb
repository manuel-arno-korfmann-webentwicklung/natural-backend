# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class CreateRowValues < ActiveRecord::Migration[5.1]
  def change
    create_table :row_values do |t|
      t.references :row, foreign_key: true
      t.references :column, foreign_key: true
      t.text :value

      t.timestamps
    end
  end
end
