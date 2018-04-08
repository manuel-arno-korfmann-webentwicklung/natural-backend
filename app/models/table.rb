class Table < ApplicationRecord
  belongs_to :table
  has_many :fields
end
