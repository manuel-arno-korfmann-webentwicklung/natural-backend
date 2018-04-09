class RowValueSerializer < ActiveModel::Serializer
  attributes :id, :value
  has_one :row
  has_one :column
end
