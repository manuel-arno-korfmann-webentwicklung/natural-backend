class Database < ApplicationRecord
  validates :name, uniqueness: { scope: :project }

  has_many :tables, dependent: :destroy
  belongs_to :project

  has_many :queries

  before_validation :generate_database_identifier, on: :create
  after_commit :trigger_db_creation, on: :create
  after_destroy :trigger_db_destruction

 private

  def generate_database_identifier
    write_attribute(:database_identifier, SecureRandom.uuid)
  end

  def trigger_db_creation
    CreateDatabaseJob.perform_later(self)
  end

  def trigger_db_destruction
    DestroyDatabaseJob.perform_later(self.database_identifier)
  end
end
