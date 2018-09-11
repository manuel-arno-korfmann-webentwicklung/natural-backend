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
    db_manager = ::Natural::DatabaseManager.new
    connection = db_manager.connect_to_database(db.database_identifier)
    connection.database.tables(project.db_username)
  end


 private

  def trigger_table_creation
    CreateTableJob.perform_later(self)
  end

  def trigger_table_destruction
    DestroyTableJob.perform_later(database.database_identifier, self.name)
  end
end
