class Api::V1::UserSerializer
  include JSONAPI::Serializer

  attributes :name, :email
end
