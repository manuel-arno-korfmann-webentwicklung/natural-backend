class AddDbUsernameToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :db_username, :string
  end
end
