class RowValue < ApplicationRecord
  belongs_to :row
  belongs_to :column
  belongs_to :user

  after_commit :trigger_value_insertion, on: :create
  after_commit :trigger_value_update, on: :update
  #before_destroy :trigger_value_deletion

  private

   def trigger_value_insertion
     if row.db_id.present?
       UpdateValueJob.perform_later(self)
     else
       InsertValueJob.perform_later(self)
     end
   end

   def trigger_value_update
     UpdateValueJob.perform_later(self)
   end

   def trigger_value_deletion
     DeleteValueJob.perform_later(column.table.database.database_identifier,
                                    column.table.name,
                                    self.column.name,
                                    row.db_id)
   end
end
