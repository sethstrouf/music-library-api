class Api::V1::UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :created_at
end
