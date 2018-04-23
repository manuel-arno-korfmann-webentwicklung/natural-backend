class SyncDbJob < ApplicationJob
  queue_as :default

  def perform()
    db_manager = ::Natural::DatabaseManager.new
    Table.all.each do |table|
      db_manager.connect_to_database(table.database.database_identifier)

      query = <<-SQL
        SELECT *
        FROM \"#{table.name}\"
        WHERE id NOT IN (#{table.rows.pluck(:db_id).compact.join(', ')});
      SQL
      puts db_manager.connection.exec(query).values
    end
  end
end
