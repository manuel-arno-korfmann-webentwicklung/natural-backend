class SyncDbJob < ApplicationJob
  queue_as :default

  def sync_db
    db_manager = ::Natural::DatabaseManager.new
    Table.all.each do |table|
      db_manager.connect_to_database(table.database.database_identifier)

      to_be_removed_ids = table.rows.pluck(:db_id)

      query = <<-SQL
        SELECT *
        FROM \"#{table.name}\"
      SQL

      db_manager.connection.exec(query).each do |row|
        row_db_id = row.values_at('id')[0].to_i

        to_be_removed_ids.delete(row_db_id)

        if Row.where(db_id: row_db_id).any?
          #TODO: add update action
        else
          natural_row = Row.create(db_id: row.values_at('id')[0], table: table, user: table.user.id)
          table.columns.each do |column|
            value = row.values_at(column.name)[0]
            RowValue.create(row: natural_row, column: column, value: value, user: table.user.id)
          end
        end

      end

      Row.where(db_id: to_be_removed_ids).destroy_all
    end
  end

  def perform
    RedisMutex.with_lock(:sync_db) do
      sync_db
    rescue RedisMutex::LockError
      Rails.logger.debug "Another job is running, exiting ..."
    end
  end
end
