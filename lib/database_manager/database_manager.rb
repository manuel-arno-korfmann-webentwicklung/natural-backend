module Natural
  class DatabaseManager
    attr_reader :connection

    def initialize
      establish_default_connection
    end

    def connect_to_database(database_name)
      @connection.close
      @connection.database = ::Natural::Database.new(database_name)
      @connection.establish_connection
      @connection.database.connection = @connection
      @connection
    end

    def establish_default_connection
      @connection = ::Natural::Connection.new
      @connection.load_rails_database_config
      @connection.establish_connection
    end

    def database_user(username, password = nil)
      database_user = ::Natural::DatabaseUser.new(username, password)
      database_user.connection = connection
      database_user
    end

    def create_user(username, password)
      database_user(username, password).create
    end

    def destroy_user(username)
      database_user(username).destroy
    end

    def user_exists?(username)
      database_user(username).exists?
    end

    def database(identifier)
      database = ::Natural::Database.new(identifier)
      database.connection = connection
      database
    end

    def create_database(identifier)
      database(identifier).create
    end

    def destroy_database(identifier)
      database(identifier).destroy
    end

    def database_exists?(identifier)
      database(identifier).exists?
    end
  end
end
