module Natural
  class Connection
    def establish_connection
      @connection = PG.connect(user: @db_user.username,
                               password: @db_user.password)
    end

    def load_rails_database_config
      config = Rails.configuration.database_configuration[Rails.env]

      @db_user = ::Natural::DatabaseUser.new(config['username'],
                                            config['password'])
    end

    def exec(*args, &block)
      @connection.exec(*args, &block)
    end
  end
end
