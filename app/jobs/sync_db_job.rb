class SyncDbJob < ApplicationJob
  queue_as :default
  
  def sync_tables
    db_manager = ::Natural::DatabaseManager.new
    Database.all.each do |database|
      next if database.name.blank?

      db_manager.connect_to_database(database.database_identifier)
      
      existing_tables = database.tables.map(&:database_identifier)
      db_manager.tables.each do |table|
        unless existing_tables.include?(table.name)
          table = database.tables.build(database_identifier: table.name, name: table.name)
          table.save!
        end
      end  
  end
  
  def sync_rows_and_columns(table = nil)
    db_manager = ::Natural::DatabaseManager.new
    (table ? Table.where(name: table) : Table.all).each do |table|
      next if table.name.blank?

      db_manager.connect_to_database(table.database.database_identifier)
      to_be_removed_ids = table.rows.pluck(:db_id)

      query = <<-SQL
        SELECT *
        FROM \"#{table.name}\"
      SQL

      db_manager.connection.exec(query).each do |row|
        row_db_id = row.values_at('id')[0].to_i

        to_be_removed_ids.delete(row_db_id)

        if app_layer_row = Row.find_by(db_id: row_db_id)
          table.columns.each do |column|
            value = row.values_at(column.name)[0]
            row_value = RowValue.find_or_create_by(row: app_layer_row, column: column, user: table.user)
            # TODO: find a more elegant solution than update_columns
            # * updates_at/update_on are not updated
            # last resort: set updated_at/update_on manually here
            # reason for using update_columns in the first place: callback skipping
            row_value.update_columns(value: value)
          end
        else
          puts "why tho?"
          app_layer_row = Row.create(db_id: row.values_at('id')[0], table: table, user: table.user)
          table.columns.each do |column|
            value = row.values_at(column.name)[0]
            puts column.name
            puts value
            RowValue.create(row: app_layer_row, column: column, value: value, user: table.user)
          end
        end

      end
      #
      Row.where(db_id: to_be_removed_ids).destroy_all
    end

    return nil
  end

  def perform
    %I[sync_rows_and_columns sync_tables].each do |method_name|
      RedisMutex.with_lock(method_name) do
        ActiveRecord::Base.logger.silence do
          public_send(method_name)
        end
      rescue RedisMutex::LockError
        Rails.logger.debug "Another job is running, exiting ..."
      end
    end
  end
end
