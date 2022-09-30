# frozen_string_literal: true

class RemoveUpvotesAndDownvotesFromPost < ActiveRecord::Migration[6.1]
  def up
    change_table :posts, bulk: true do |t|
      t.remove :upvotes, :downvotes
    end
  end

  def down
    change_table :posts, bulk: true do |t|
      t.integer :upvotes, :downvotes
    end
  end
end
