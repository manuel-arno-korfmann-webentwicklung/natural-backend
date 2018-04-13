class Query < ApplicationRecord
  serialize :response_data
  
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
