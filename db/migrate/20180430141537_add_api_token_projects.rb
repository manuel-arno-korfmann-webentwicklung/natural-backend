class AddApiTokenProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :api_token, :string
  end
end
