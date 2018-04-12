class Row < ApplicationRecord
  belongs_to :table
  has_many :row_values, dependent: :destroy

  after_destroy :trigger_row_deletion

  private

   def trigger_row_deletion
     DeleteRowJob.perform_later(table.database.database_identifier,
                                    table.name,
                                    db_id)
   end
end
