class Table < ApplicationRecord
  has_many :columns
  has_many :rows
end
