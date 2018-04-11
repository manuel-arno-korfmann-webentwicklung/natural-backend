module Natural
  class Table
    include ConnectionProvidable

    attr_reader :identifier
    attr_accessor :database

    def initialize(identifier)
      @identifier = identifier
    end

    def create
      connection.exec(
        """
        CREATE TABLE #{@identifier} (
          id SERIAL
        );
        """
      )
      self
    end

    def destroy
      connection.exec(
        """
        DROP TABLE #{@identifier};
        """
      )
    end

    def exists?
      '1' == connection.exec(
        """
        SELECT 1
        FROM pg_tables
        WHERE tablename = '#{@identifier}'
        """
      ).values[0].try(:[], 0)
    end
  end
end
