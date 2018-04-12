# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class RowValue < ApplicationRecord
  belongs_to :row
  belongs_to :column

  after_commit :trigger_value_insertion, on: :create
  after_commit :trigger_value_update, on: :update
  #before_destroy :trigger_value_deletion

  private

   def trigger_value_insertion
     InsertValueJob.perform_later(self)
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
