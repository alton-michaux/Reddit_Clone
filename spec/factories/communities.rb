# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :community do |f|
    f.account_id { [FactoryBot.create(:account)].pluck('id').join }
    f.summary { Faker::Lorem.paragraph(sentence_count: 2) }
    f.url { Faker::Internet.url }
    f.name { Faker::Team.name.titleize }
    f.rules { Faker::Lorem.paragraph(sentence_count: 5) }
  end
end
