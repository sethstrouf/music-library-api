require 'json_web_token'

class ApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: {
      'errors': [
        {
          'status': '404',
          'title': 'Not Found'
        }
      ]
    }, status: 404
  end

  def render_json_response(resource)
    if resource.errors.empty?
      render json: resource
    else
      render json: resource.errors, status: 400
    end
  end

  def authorize!
    valid, result = verify(raw_token(request.headers))
    render json: { message: result }.to_json, status: :unauthorized unless valid
    @token ||= result
  end

  protected

  def current_user
    token = request&.headers['Authorization']&.split&.last
    Warden::JWTAuth::UserDecoder.new.call(token, :user, nil) if token.present?
  end

  private

  def verify(token)
    payload, = JsonWebToken.verify(token)
    [true, payload]
  rescue JWT::DecodeError => e
    [false, e]
  end

  def raw_token(headers)
    return headers['Authorization'].split.last if headers['Authorization'].present?
    nil
  end
end
