module Natural
  class Connection
    attr_accessor :db_user
    attr_accessor :database

    def establish_connection
      options_hash = {
        user: @db_user.username,
        password: @db_user.password
      }

      if database.present?
        options_hash.merge!({dbname: database.identifier})
      end

      @connection = PG.connect(options_hash)
    end

    def load_rails_database_config
      config = Rails.configuration.database_configuration[Rails.env]

      @db_user = ::Natural::DatabaseUser.new(config['username'],
                                            config['password'])
    end

    def exec(*args, &block)
      @connection.exec(*args, &block)
    end

    def clone_with_database(database)
      clone = self.class.new
      clone.db_user = self.db_user
      clone.database = database
      clone.establish_connection
      clone
    end
  end

  module ConnectionProvidable
    def self.included(base)
      attr_accessor :connection
    end
  end
end
