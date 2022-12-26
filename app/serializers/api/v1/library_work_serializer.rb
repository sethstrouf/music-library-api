class Api::V1::LibraryWorkSerializer
  include JSONAPI::Serializer

  attributes :quantity, :last_performed, :work, :library
end
