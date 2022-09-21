class SubscriptionsController < ApplicationController
    def new
        @account = current_account
        @community = Community.find(subscription_params[:community_id])
        @subscription = Subscription.new(account_id: @account.id, community_id: @community.id)
    end

    def create
        @subscription = Subscription.new(community_id: subscription_params[:community_id], account_id: subscription_params[:account_id])

        if @subscription.save
            flash.notice = "Welcome to #{@community.name}!"
        else
            flash.alert = "Unable to join #{@community.name}"
        end
        redirect_to community_url(id: @community.id)
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
        params.fetch(:subscription, {}).permit(:account_id, :community_id)
    end
end
