# frozen_string_literal: true

class PublicController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  rescue_from StandardError, with: :catch_no_method

  def index
    @communities = Community.all.limit(5)
    @posts = Post.order(id: :desc).limit(20)
  end

  def profile
    @profile = Account.find(params[:id])
    @posts = @profile.posts
    @communities = @profile.communities
  end

  private

  def catch_not_found(e)
    Rails.logger.debug('There was a not found exception in public_controller.')
    flash.alert = e.to_s
    redirect_to root_url
  end

  def catch_no_method(e)
    Rails.logger.debug("There was a 'NoMethodError' in public_controller: #{e} (the object may have been created without all it's attributes.)")
    flash.alert = e.to_s
    redirect_to root_url
  end
end
