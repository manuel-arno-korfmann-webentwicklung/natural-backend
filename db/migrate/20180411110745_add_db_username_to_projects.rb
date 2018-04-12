# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class AddDbUsernameToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :db_username, :string
  end
end
