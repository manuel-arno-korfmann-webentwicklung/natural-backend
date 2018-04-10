class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :name, :type
  belongs_to :table
  has_many :row_values
end
