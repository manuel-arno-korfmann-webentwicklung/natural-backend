class RowSerializer < ActiveModel::Serializer
  attributes :id
  has_one :table
end
