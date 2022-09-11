class Api::V1::UserSerializer
  include JSONAPI::Serializer

  attributes :email

  # link :self do
  #   @url_helpers.api_user_url(@object.id)
  # end
end
