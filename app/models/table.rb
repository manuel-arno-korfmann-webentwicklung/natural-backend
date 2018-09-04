class Table < ApplicationRecord
  validates :name, presence: true

  has_many :columns, dependent: :destroy
  has_many :rows, dependent: :destroy
  belongs_to :database
  belongs_to :user

  after_commit :trigger_table_creation, on: :create
  before_destroy :trigger_table_destruction

  def self.for_database_id(database_id)
    # Get the database associated with the database id
    db = Database.find(database_id)
    # Get the project asscoiated with this database
    project = Project.find(db.project_id)
    # Get the users of the associated database
    associated_database_user = ::Natural::DatabaseUser.new(project.db_username,project.db_password)
    associated_database = ::Natural::Database.new(db.database_identifier)
    connection = ::Natural::Connection.new
    connection.db_user = associated_database_user
    connection.database = associated_database
     # Connect to the associated db
    connection.establish_connection
    associated_database.connection = connection
     # Get all the tables  in the associated db for the associated user
    tables = associated_database.tables(project.db_username)
     # Close connection after query
    connection.close
     # Return the result
    tables.to_a.entries
  end


 private

  def trigger_table_creation
    CreateTableJob.perform_later(self)
  end

  def trigger_table_destruction
    DestroyTableJob.perform_later(database.database_identifier, self.name)
  end
end
