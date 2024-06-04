# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    Rails.logger.info "Received parameters: #{params.inspect}"
    super do |resource|
      if resource.errors.any?
        Rails.logger.info "User sign up failed: #{resource.errors.full_messages.join(", ")}"
      end
    end
  end

  # PUT /resource
  def update
    super do |resource|
      if resource.errors.any?
        Rails.logger.info "User update failed: #{resource.errors.full_messages.join(", ")}"
      end
    end
  end

  protected

  # Permit the required parameters for sign up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  end

  # Permit the required parameters for account update
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
