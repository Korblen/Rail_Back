# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed in successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { code: 401, message: 'Unauthorized' },
        data: resource.errors
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.secrets.secret_key_base).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        status: { code: 200, message: 'Signed out successfully.' }
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: 'Unauthorized' }
      }, status: :unauthorized
    end
  end
end
