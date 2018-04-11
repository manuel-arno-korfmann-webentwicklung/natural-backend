module Natural
  class DatabaseUser
    attr_reader :username, :password

    def initialize(username, password = nil)
      @username = username
      @password = password
    end

    def create(connection)
      connection.exec(
        """
        CREATE USER \"#{@username}\" WITH PASSWORD \'#{@password}\'
        """
      )
    end

    def destroy(connection)
      connection.exec(
        """
        DROP USER \"#{@username}\";
        """
      )
    end

    def exists?(connection)
      '1' == connection.exec(
        """
        SELECT 1 FROM pg_roles WHERE rolname='#{@username}'
        """
      ).values[0].try(:[], 0)
    end
  end
end
