class AddDbidToRows < ActiveRecord::Migration[5.1]
  def change
    add_column :rows, :db_id, :integer
  end
end
