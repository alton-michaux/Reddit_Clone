require 'faker'

FactoryBot.define do
  factory :community do |f|
    f.account_id { [FactoryBot.create(:account)].pluck('id').join }
    f.name { Faker::Team.name }
    f.url { Faker::Internet.url }
    f.rules { Faker::Lorem.paragraph(sentence_count: 5)}
  end
end