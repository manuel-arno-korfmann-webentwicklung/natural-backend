module Natural
  class DatabaseManager
    attr_reader :connection

    def initialize
      establish_default_connection
    end

    def establish_default_connection
      @connection = ::Natural::Connection.new
      @connection.load_rails_database_config
      @connection.establish_connection
    end

    def create_user(username, password)
      database_user = ::Natural::DatabaseUser.new(username, password)
      database_user.create(connection)
    end

    def destroy_user(username)
      database_user = ::Natural::DatabaseUser.new(username)
      database_user.destroy(connection)
    end

    def user_exists?(username)
      database_user = ::Natural::DatabaseUser.new(username)
      database_user.exists?(connection)
    end
  end
end
