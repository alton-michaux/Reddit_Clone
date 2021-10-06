# frozen_string_literal: true

class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities do |t|
      t.references :account
      t.string :name
      t.string :url
      t.integer :total_members
      t.text :rules

      t.timestamps
    end
  end
end
