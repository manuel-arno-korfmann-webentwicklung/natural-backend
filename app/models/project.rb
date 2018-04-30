require 'securerandom'
class Project < ApplicationRecord
  validates :name, :db_username, presence: true

  belongs_to :user
  
  has_many :databases, dependent: :destroy
  before_validation :generate_db_credentials, on: :create
  after_create :trigger_db_user_creation
  after_destroy :trigger_db_user_destruction

 private

  def generate_db_credentials
    write_attribute(:db_username, SecureRandom.uuid)
    write_attribute(:db_password, SecureRandom.hex(42))
  end

  def trigger_db_user_creation
    CreateDatabaseUserJob.perform_later(self.db_username, self.db_password)
  end

  def trigger_db_user_destruction
    DestroyDatabaseUserJob.perform_later(self.db_username)
  end
end
