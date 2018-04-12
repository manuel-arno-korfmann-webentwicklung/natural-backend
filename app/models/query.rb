class Query < ApplicationRecord
  belongs_to :database
  after_commit :trigger_run_query, on: :create

  private

   def trigger_run_query
     RunQueryJob.perform_later(self)
   end
end
