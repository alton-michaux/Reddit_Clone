# frozen_string_literal: true

class Community < ApplicationRecord
  belongs_to :account
  has_many :posts
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :account
  # validates :subscribers, uniqueness: { scope: :account_id, case_sensitive: false }

  validates_presence_of :url, :name, :rules, :summary
  validates_associated :account

  def subscriber_count
    Subscription.count
  end
end
