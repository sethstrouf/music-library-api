class Api::V1::LibraryWorkSerializer
  include JSONAPI::Serializer

  attributes :index, :quantity, :last_performed, :checked_out, :work, :library
end
