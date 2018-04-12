class CreateTableJob < ApplicationJob
  queue_as :default

  def perform(table)
    db_user = ::Natural::DatabaseUser.new(table.database.project.db_username,
                                          table.database.project.db_password)
    database = ::Natural::Database.new(table.database.database_identifier)
    connection = ::Natural::Connection.new
    connection.db_user = db_user
    connection.database = database

    connection.establish_connection

    table = ::Natural::Table.new(table.name)
    table.connection = connection

    table.create

    connection.close
  end
end
