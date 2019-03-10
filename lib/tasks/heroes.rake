require 'open-uri'

namespace :heroes do
  task persist: :environment do
    heroes = JSON.load(open('https://overwatch-api.net/api/v1/hero'))
    heroes['data'].each do |hero|
      Hero.create(
        source_id: hero['id'],
        name: hero['name'],
        real_name: hero['real_name'],
        health: hero['health'],
        armour: hero['armour'],
        shield: hero['shield']
      )
    end

    abilities_url = 'https://overwatch-api.net/api/v1/ability'
    loop do
      abilities = JSON.load(open(abilities_url))
      abilities['data'].each do |ability|
        Ability.create(
          source_id: ability['id'],
          name: ability['name'],
          description: ability['description'],
          is_ultimate: ability['is_ultimate'],
          hero: Hero.find_by(source_id: ability['hero']['id'])
        )
      end
      abilities['next'].present? ? abilities_url = abilities['next'] : break
    end
  end
end
