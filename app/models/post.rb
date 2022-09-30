# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :account
  belongs_to :community

  validates_presence_of :title, :body, :account_id, :community_id, :upvotes, :downvotes
  validates_associated :account, :community

  acts_as_votable
end
