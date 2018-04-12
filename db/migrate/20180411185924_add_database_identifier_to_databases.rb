class AddDatabaseIdentifierToDatabases < ActiveRecord::Migration[5.1]
  def change
    add_column :databases, :database_identifier, :string
    add_index :databases, :database_identifier, unique: true
  end
end
