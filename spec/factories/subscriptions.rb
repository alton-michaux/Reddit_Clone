# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do |t|
    t.account_id { [FactoryBot.create(:account)].pluck('id').join }
    t.community_id { [FactoryBot.create(:community)].pluck('id').join }
  end
end
