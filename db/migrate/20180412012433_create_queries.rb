class CreateQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :queries do |t|
      t.text :request_data
      t.text :response_data
      t.references :database

      t.timestamps
    end
  end
end
