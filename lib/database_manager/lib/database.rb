module Natural
  class Database
    include ConnectionProvidable

    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
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
