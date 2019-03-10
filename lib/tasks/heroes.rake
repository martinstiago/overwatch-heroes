# frozen_string_literal: true

namespace :heroes do
  task persist: :environment do
    base_url = 'https://overwatch-api.net/api/v1/'

    %w[hero ability].each do |resource|
      resource_url = base_url + resource

      loop do
        resources = JSON.parse(Net::HTTP.get(URI(resource_url)), symbolize_names: true)
        resources[:data].each do |fetched_resource|
          record = resource.capitalize.constantize
                           .send(:find_or_initialize_by, source_id: fetched_resource[:id])
          record.update(send("#{resource}_params", fetched_resource))
        end
        resources[:next].present? ? resource_url = resources[:next].sub('http', 'https') : break
      end
    end
  end
end

private

def hero_params(resource)
  {
    name: resource[:name],
    real_name: resource[:real_name],
    health: resource[:health],
    armour: resource[:armour],
    shield: resource[:shield]
  }
end

def ability_params(resource)
  {
    name: resource[:name],
    description: resource[:description],
    is_ultimate: resource[:is_ultimate],
    hero: Hero.find_by(source_id: resource[:hero][:id])
  }
end
