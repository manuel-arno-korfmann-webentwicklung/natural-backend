class Table < ApplicationRecord
  validates :name, presence: true

  has_many :columns, dependent: :destroy
  has_many :rows, dependent: :destroy
  belongs_to :database
  belongs_to :user

  after_commit :trigger_table_creation, on: :create
  before_destroy :trigger_table_destruction

 private

  def trigger_table_creation
    CreateTableJob.perform_later(self)
  end

  def trigger_table_destruction
    DestroyTableJob.perform_later(database.database_identifier, self.name)
  end
end
