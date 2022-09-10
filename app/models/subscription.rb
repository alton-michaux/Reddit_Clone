# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :account
  belongs_to :community
end
