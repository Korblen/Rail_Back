# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json
 
  private

  def repond_with(resource, options={})

    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: resource
      }
    else
      render json: {
        status: { code: 422, message: 'User could not be created' },
        data: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end
