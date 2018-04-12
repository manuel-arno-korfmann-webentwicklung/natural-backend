class RunQueryJob < ApplicationJob
  queue_as :default

  def perform(query)
    db_user = ::Natural::DatabaseUser.new(query.database.project.db_username,
                                        query.database.project.db_password)
    db = ::Natural::Database.new(query.database.database_identifier)

    connection = ::Natural::Connection.new
    connection.db_user = db_user
    connection.database = db

    connection.establish_connection

    result = connection.exec(query.request_data).values.to_json
    query.update_attribute(:response_data, result)

    connection.close
  end
end
