class SubscriptionsController < ApplicationController
    def new
        @subscription = Subscription.new
    end

    def create
        # byebug
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
end
