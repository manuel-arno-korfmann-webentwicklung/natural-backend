class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :api_token
  has_many :databases
end
