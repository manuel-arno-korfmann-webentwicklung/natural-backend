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
        CREATE TABLE \"#{@identifier}\" (
          id SERIAL
        );
        """
      )
      self
    end

    def destroy
      connection.exec(
        """
        DROP TABLE \"#{@identifier}\";
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

    def add_column(name)
      connection.exec(
        """
        ALTER TABLE \"#{@identifier}\"
          ADD COLUMN \"#{name}\" varchar(255);
        """
      )
    end

    def destroy_column(name)
      connection.exec(
        """
        ALTER TABLE \"#{@identifier}\"
          DROP COLUMN \"#{name}\" RESTRICT;
        """
      )
    end

    def insert_value(column_name, value)
      connection.exec(
        """
        INSERT INTO \"#{@identifier}\" (\"#{column_name}\")
        VALUES ('#{value}')
        RETURNING ID;
        """
      ).values[0][0]
    end

    def delete_value(column_name, id)
      connection.exec(
        """
        UPDATE \"#{@identifier}\"
        SET \"#{column_name}\" = NULL
        WHERE id=#{id};
        """
      )
    end
  end
end
