class Api::V1::UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :first_name, :last_name, :name, :created_at, :libraries
end
