class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :name, :type
  belongs_to :table
end
