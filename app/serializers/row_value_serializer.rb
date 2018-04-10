class RowValueSerializer < ActiveModel::Serializer
  attributes :id, :value
  belongs_to :row
  belongs_to :column
end
