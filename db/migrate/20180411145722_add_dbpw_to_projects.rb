class AddDbpwToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :db_password, :string
  end
end
