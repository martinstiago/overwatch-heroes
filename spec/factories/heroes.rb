# frozen_string_literal: true

FactoryBot.define do
  factory :hero do
    sequence(:source_id) { |n| n }
    name { Faker::Games::Overwatch.hero }
    real_name { Faker::Name.name }
    health { Faker::Number.number(3) }
    armour { Faker::Number.number(3) }
    shield { Faker::Number.number(3) }

    after :create do |hero|
      create_list :ability, 3, hero: hero
      create :ability, :ultimate, hero: hero
    end
  end
end
