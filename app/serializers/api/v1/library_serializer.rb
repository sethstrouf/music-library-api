class Api::V1::LibrarySerializer
  include JSONAPI::Serializer

  attributes :name, :library_works
end
