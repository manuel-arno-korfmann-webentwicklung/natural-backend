class Database < ApplicationRecord
  has_many :tables
  belongs_to :project
end
