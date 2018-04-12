# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class Query < ApplicationRecord
  attr_accessor :instant_execution
  belongs_to :database
  after_commit :trigger_run_query, on: :create

  def run_query
    ::RunQueryJob.perform_now(self)
    response_data
  end

  private

   def trigger_run_query
     unless instant_execution
       RunQueryJob.perform_later(self)
     end
   end
end
