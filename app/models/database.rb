class Database < ApplicationRecord
  validates :name, uniqueness: { scope: :project }

  belongs_to :user

  has_many :tables, dependent: :destroy
  belongs_to :project

  has_many :queries

  before_validation :generate_database_identifier, on: :create
  after_commit :trigger_db_creation, on: :create
  after_destroy :trigger_db_destruction

  def postgres_url
	  "postgres://#{project.db_username}:#{project.db_password}@#{self.ip}/#{database_identifier}"
  end

  def ip
	Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address)
  end

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
