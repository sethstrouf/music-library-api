class Api::V1::WorkSerializer
  include JSONAPI::Serializer

  attributes :index, :title, :composer, :genre, :publishing_year
end
