# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class CreateQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :queries do |t|
      t.text :request_data
      t.text :response_data
      t.references :database

      t.timestamps
    end
  end
end
