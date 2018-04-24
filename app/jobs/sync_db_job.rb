class SyncDbJob < ApplicationJob
  queue_as :default

  def perform()
    db_manager = ::Natural::DatabaseManager.new
    Table.all.each do |table|
      db_manager.connect_to_database(table.database.database_identifier)

      query = <<-SQL
        SELECT *
        FROM \"#{table.name}\"
      SQL

      query_extension = <<-SQL
        WHERE id NOT IN (#{table.rows.pluck(:db_id).compact.join(', ')});
      SQL

      query += query_extension if table.rows.any?

      db_manager.connection.exec(query).each do |row|
        natural_row = Row.create(db_id: row.values_at('id'), table: table)
        table.columns.each do |column|
          value = row.values_at(column.name)[0]
          RowValue.create(row: natural_row, column: column, value: value)
        end
      end
    end
  end
end
