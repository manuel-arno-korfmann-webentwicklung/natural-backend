class DatabaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :postgres_url

  belongs_to :project
  has_many :tables
end
