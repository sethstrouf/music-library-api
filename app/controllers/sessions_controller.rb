# class SessionsController < Devise::SessionsController

#   private

#     def respond_with(resource, _opts = {})
#       if resource.errors.empty?
#         render json: Api::V1::UserSerializer.new(resource).serializable_hash
#       else
#         render json: resource.errors, status: 400
#       end
#     end

#     def respond_to_on_destroy
#       head :no_content
#     end
# end
