require_relative './connection.rb'

module Natural
  class Database
    include ::Natural::ConnectionProvidable

    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
    end

    def table(table_identifier)
      table = Table.new(table_identifier)
      table.connection = connection.clone_with_database(self)
      table.database = self
      table
    end

    def create_table(table_identifier)
      table(table_identifier).create
    end

    def destroy_table(table_identifier)
      table(table_identifier).destroy
    end

    def table_exists?(table_identifier)
      table(table_identifier).exists?
    end

    def tables(associated_db_user)
      connection.exec(
        """
        SELECT tablename FROM pg_catalog.pg_tables WHERE tableowner = \'#{associated_db_user}\';
        """
      )
    end

    def create
      connection.exec(
        """
        CREATE DATABASE \"#{@identifier}\"
        """
      )
      self
    end

    def destroy
      connection.exec(
        """
        DROP DATABASE \"#{@identifier}\";
        """
      )
    end

    def exists?
      '1' == connection.exec(
        """
        SELECT 1 FROM pg_database WHERE pg_database.datname = \'#{@identifier}\';
        """
      ).values[0].try(:[], 0)
    end
  end
end
