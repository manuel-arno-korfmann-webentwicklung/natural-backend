# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

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
