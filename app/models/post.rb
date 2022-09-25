# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :account
  belongs_to :community

  validates_presence_of :title, :body, :account_id, :community_id, :upvotes, :downvotes
  validates_associated :account, :community
  # account_community

  # def account_community
  #   if self.account.communities.include?(self.community)
  #     errors.add(:account, "Must be a member to post")
  #   end
  # end
end
