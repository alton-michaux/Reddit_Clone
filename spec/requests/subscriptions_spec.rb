require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  let(:account) { FactoryBot.create(:account)}
  let(:community) { FactoryBot.create(:community) }

  describe "posts new subscription path" do
    it "creates a new subscription" do
      sign_in account
      expect { post community_subscriptions_path(account_id: account.id, community_id: community.id) }.to change(Subscription, :count).by(1)
      expect(response).to redirect_to community_path(id: community.id)
      sign_out account
    end
  end
  describe "delete subscription path" do
    it "deletes a subscription" do
      sign_in account
      subscription = FactoryBot.create(:subscription, account_id: account.id, community_id: community.id)
      expect { delete community_subscription_path(id: subscription.id, community_id: community.id, account_id: account.id) }.to change(Subscription, :count).by(-1)
      expect(response).to redirect_to communities_path
    end
  end
end
