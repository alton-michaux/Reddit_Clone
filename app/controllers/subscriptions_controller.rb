class SubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  rescue_from StandardError, with: :catch_no_method
  # before_action :authenticate_account!, except: %i[index show]
  before_action :set_community, except: %i[index]

  def index
    @subscriptions = current_account.subscriptions
  end

  def show; end

  def edit; end

  def new
    @subscription = Subscription.new
  end

  def create
    @community = Community.find_by(id: subscription_params[:community_id])
    @subscription = Subscription.new(community_id: @community.id, account_id: subscription_params[:account_id])

    if @subscription.save
        flash.notice = "Welcome to #{@community.name}!"
        redirect_to community_url(id: @community.id)
    else
        flash.alert = "Unable to join #{@community.name}"
        redirect_to communities_url
    end
  end

  def update
    respond_to do |format|
      if @subscription.update(post_values)
        format.html { redirect_to @community, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @community = Community.find(subscription_params[:community_id])
    if @subscription.destroy
        flash.notice = "You left #{@community.name}"
        redirect_to communities_url
    else
        flash.alert = "Unable to leave #{@community.name}"
        redirect_to community_url(id: @community.id)
    end
  end

  private 

  def subscription_params
    params.permit(:account_id, :community_id)
  end
    
  def set_community
    @community = Community.find(params[:community_id])
  end

  def catch_not_found(e)
    Rails.logger.debug('There was a not found exception in subscriptions_controller.')
    flash.alert = e.to_s
    redirect_to communities_url
  end

  def catch_no_method(e)
    Rails.logger.debug("There was a 'NoMethodError' in subscriptions_controller: #{e} (the object may have been created without all it's attributes.)")
    flash.alert = e.to_s
    redirect_to communities_url
  end
end
