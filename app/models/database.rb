class Database < ApplicationRecord
  validates :name, uniqueness: { scope: :project }

  has_many :tables, dependent: :destroy
  belongs_to :project

  before_validation :generate_database_identifier, on: :create
  after_create :trigger_db_creation
  after_destroy :trigger_db_destruction

 private

  def generate_database_identifier
    write_attribute(:database_identifier, SecureRandom.uuid)
  end

  def trigger_db_creation
    CreateDatabaseJob.perform_later(database_identifier)
  end

  def trigger_db_destruction
    DestroyDatabaseJob.perform_later(database_identifier)
  end
end
