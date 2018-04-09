class AddDatabaseReferenceToTables < ActiveRecord::Migration[5.1]
  def change
    add_reference :tables, :database, foreign_key: true
  end
end
