class Database < ApplicationRecord
  has_many :tables, dependent: :destroy
  belongs_to :project
end
