# frozen_string_literal: true

FactoryBot.define do
  factory :ability do
    sequence(:source_id) { |n| n }
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    is_ultimate { false }
    hero

    trait :ultimate do
      is_ultimate { true }
    end
  end
end
