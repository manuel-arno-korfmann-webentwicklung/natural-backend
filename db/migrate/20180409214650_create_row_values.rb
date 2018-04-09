class CreateRowValues < ActiveRecord::Migration[5.1]
  def change
    create_table :row_values do |t|
      t.references :row, foreign_key: true
      t.references :column, foreign_key: true
      t.text :value

      t.timestamps
    end
  end
end
