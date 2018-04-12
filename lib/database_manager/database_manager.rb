# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

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
