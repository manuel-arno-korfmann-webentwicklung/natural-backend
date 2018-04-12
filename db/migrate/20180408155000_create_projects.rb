# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name

      t.timestamps
    end
  end
end
