class RunQueryJob < ApplicationJob
  queue_as :default
  
  def exceptions_matching(&block)
    Class.new do
      def self.===(other)
        @block.call(other)
      end
    end.tap do |c|
      c.instance_variable_set(:@block, block)
    end
  end

  def perform(query)
    db_user = ::Natural::DatabaseUser.new(query.database.project.db_username,
                                        query.database.project.db_password)
    db = ::Natural::Database.new(query.database.database_identifier)

    connection = ::Natural::Connection.new
    connection.db_user = db_user
    connection.database = db

    connection.establish_connection

    begin
      result = connection.exec(query.request_data).values
      query.update_attribute(:response_data, result)
    rescue exceptions_matching { |e| e.class.name.split('::')[0] == 'PG' } => e
      # TODO: Add error field to query and render a 500 + error message in queries#create in case of an error
      query.update_attribute(:response_data, {error: e.message})
    ensure
      connection.close
    end
  end
end
