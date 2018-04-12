# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class Query < ApplicationRecord
  belongs_to :database
  after_commit :trigger_run_query, on: :create

  private

   def trigger_run_query
     RunQueryJob.perform_later(self)
   end
end
