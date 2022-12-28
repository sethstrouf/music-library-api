class Api::V1::WorkSerializer
  include JSONAPI::Serializer

  attributes :title, :composer, :genre, :publishing_year
end
