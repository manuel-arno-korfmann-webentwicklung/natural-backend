class RowSerializer < ActiveModel::Serializer
  attributes :id, :db_id
  belongs_to :table
  has_many :row_values
end
