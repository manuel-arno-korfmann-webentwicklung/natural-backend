class DatabaseSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :project
  has_many :tables
end
