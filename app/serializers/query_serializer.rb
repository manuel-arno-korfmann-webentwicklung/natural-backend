class QuerySerializer < ActiveModel::Serializer
  attributes :id, :request_data, :response_data
end
