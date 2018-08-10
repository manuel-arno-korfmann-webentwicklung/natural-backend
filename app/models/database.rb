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
	  "postgres://#{project.db_username}:#{project.db_password}@#{self.server_public_ip}/#{database_identifier}"
  end

  # REFACTOR: ServerInfo Service object
  def server_public_ip
	Socket.ip_address_list.detect { |intf| intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast? and !intf.ipv4_private? }
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
