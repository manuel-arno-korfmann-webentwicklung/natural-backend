class Column < ApplicationRecord
  belongs_to :table
  belongs_to :user
  has_many :row_values, dependent: :destroy

  after_commit :trigger_column_creation, on: :create
  before_destroy :trigger_column_destruction

  validate :invalid_column_names

 private

 def invalid_column_names
   if name.blank?
     errors.add(:name, "Name can't be blank")
   end

   if name == 'id'
     errors.add(:name, "Name cannot be id")
   end
 end

  def trigger_column_creation
    CreateColumnJob.perform_later(self)
  end

  def trigger_column_destruction
    DestroyColumnJob.perform_later(table.database.database_identifier,
                                   table.name,
                                   self.name)
  end
end
