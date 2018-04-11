class Table < ApplicationRecord
  has_many :columns, dependent: :destroy
  has_many :rows, dependent: :destroy
  belongs_to :database
end
