class Table < ApplicationRecord
  has_many :columns
  has_many :rows
  belongs_to :database
end
