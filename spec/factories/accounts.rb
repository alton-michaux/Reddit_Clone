# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :account do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name  { Faker::Name.last_name }
    f.username { Faker::Internet.username }
    f.bio { Faker::Lorem.paragraph(sentence_count: 3) }
    f.email { Faker::Internet.email }

  end
end
