# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from NoMethodError, with: :catch_no_method

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name username bio])
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username bio])
  end

  private

  def catch_no_method(e)
    Rails.logger.debug("There was a 'NoMethodError': #{e} (the object may have been created without all it's attributes.)")
    flash.alert = e.to_s
    redirect_to root_url
  end
end
