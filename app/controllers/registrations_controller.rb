# class RegistrationsController < Devise::RegistrationsController
#   def create
#     build_resource(sign_up_params)
#     resource.save
#     sign_up(resource_name, resource) if resource.persisted?
#     render_response(resource)
#   end

#   private

#     def render_response(resource)
#       if resource.errors.empty?
#         render json: Api::V1::UserSerializer.new(resource).serializable_hash
#       else
#         render json: resource.errors, status: 400
#       end
#     end
# end
