class TableSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :rows
  has_many :columns

  belongs_to :database
end
