class Row < ApplicationRecord
  belongs_to :table
  has_many :row_values, dependent: :destroy
end
