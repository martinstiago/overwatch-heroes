# frozen_string_literal: true

namespace :heroes do
  task persist: :environment do
    base_url = 'https://overwatch-api.net/api/v1/'

    %i[hero ability].each do |resource|
      resource_url = base_url + resource.to_s

      loop do
        resources = JSON.parse(Net::HTTP.get(URI(resource_url)))
        resources['data'].each do |fetched_resource|
          send("create_#{resource}", fetched_resource)
        end
        resources['next'].present? ? resource_url = resources['next'].sub('http', 'https') : break
      end
    end
  end
end

private

def create_hero(hero)
  Hero.create(
    source_id: hero['id'],
    name: hero['name'],
    real_name: hero['real_name'],
    health: hero['health'],
    armour: hero['armour'],
    shield: hero['shield']
  )
end

def create_ability(ability)
  Ability.create(
    source_id: ability['id'],
    name: ability['name'],
    description: ability['description'],
    is_ultimate: ability['is_ultimate'],
    hero: Hero.find_by(source_id: ability['hero']['id'])
  )
end
