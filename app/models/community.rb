# frozen_string_literal: true

class Community < ApplicationRecord
  belongs_to :account
  has_many :posts
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :account

  validates_presence_of :url, :name, :rules
  validates_associated :account
end
