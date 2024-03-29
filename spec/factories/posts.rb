# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :post do |f|
    f.account_id { [FactoryBot.create(:account)].pluck('id').join }
    f.community_id { [FactoryBot.create(:community)].pluck('id').join }

    f.title { Faker::Book.title }
    f.body { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
