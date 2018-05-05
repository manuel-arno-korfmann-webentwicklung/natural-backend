module Natural
  class Table
    TYPE_IDENTIFIER_MAPPING = {
      'varchar_255' => 'varchar(255)',
    }

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

    def update_column_type(name, type_identifier)
      type = TYPE_IDENTIFIER_MAPPING[type_identifier] || type_identifier

      connection.exec(
        """
        ALTER TABLE \"#{@identifier}\"
          ALTER COLUMN \"#{name}\" TYPE #{type} USING (trim(\"#{name}\" )::#{type});
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
        VALUES ('#{single_quote_escape(value)}')
        RETURNING ID;
        """
      ).values[0][0]
    end

    def update_value(column_name, id, value)
      connection.exec(
        """
        UPDATE \"#{@identifier}\"
        SET \"#{column_name}\" = \'#{single_quote_escape(value)}\'
        WHERE id=#{id};
        """
      )
    end

    def single_quote_escape(string)
      string.gsub("'", %q(\\\'))
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

    def has_row?(id)
      connection.exec(
        """
        SELECT 1
        FROM \"#{@identifier}\"
        WHERE id=#{id};
        """
      ).values[0][0] == '1'
    end

    def delete_row(id)
      connection.exec(
        """
        DELETE FROM \"#{@identifier}\"
        WHERE id=#{id};
        """
      )
    end
  end
end
