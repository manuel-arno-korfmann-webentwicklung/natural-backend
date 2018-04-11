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
      database_user.connection = connection
      database_user.create
    end

    def destroy_user(username)
      database_user = ::Natural::DatabaseUser.new(username)
      database_user.connection = connection
      database_user.destroy
    end

    def user_exists?(username)
      database_user = ::Natural::DatabaseUser.new(username)
      database_user.connection = connection
      database_user.exists?
    end

    def create_database(identifier)
      database = ::Natural::Database.new(identifier)
      database.connection = connection
      database.create
    end

    def destroy_database(identifier)
      database = ::Natural::Database.new(identifier)
      database.connection = connection
      database.destroy
    end

    def database_exists?(identifier)
      database = ::Natural::Database.new(identifier)
      database.connection = connection
      database.exists?
    end
  end
end
