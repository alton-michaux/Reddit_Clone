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
  
    def new; end
  
    def create
      @subscription = Subscription.new(params[account_id: current_account.id, community_id: @community.id])
  
      if @subscription.save
        redirect_to community_path(id: @community.id)
      else
        @community = Community.find(params[:community_id])
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
        render :new
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
      @subscription.destroy
      respond_to do |format|
        format.html { redirect_to community_url(@community.id), notice: 'You have left this community.' }
        format.json { head :no_content }
      end
    end
  
    private
  
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
  