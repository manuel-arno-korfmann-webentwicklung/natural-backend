class AddUserRefToColumns < ActiveRecord::Migration[5.1]
  def change
    add_reference :columns, :user, foreign_key: true
  end
end
