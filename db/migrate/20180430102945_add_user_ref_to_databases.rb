class AddUserRefToDatabases < ActiveRecord::Migration[5.1]
  def change
    add_reference :databases, :user, foreign_key: true
  end
end
