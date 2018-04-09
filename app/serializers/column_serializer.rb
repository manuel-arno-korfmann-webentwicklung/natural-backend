class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :name, :type
  has_one :table
end
