# frozen_string_literal: true

require 'net/http'

module Heroes
  class PersistanceService
    BASE_URL = 'https://overwatch-api.net/api/v1/'

    attr_reader :resources

    def initialize
      @resources = %w[hero ability]
    end

    def persist
      resources.each do |resource|
        resource_url = BASE_URL + resource

        loop do
          resources = JSON.parse(Net::HTTP.get(URI(resource_url)), symbolize_names: true)
          resources[:data].each { |fetched_resource| create_or_update_resource(resource, fetched_resource) }
          resources[:next].present? ? resource_url = resources[:next].sub('http', 'https') : break
        end
      end
    end

    private

    def create_or_update_resource(resource, fetched_resource)
      record = resource.capitalize.constantize.send(:find_or_initialize_by, source_id: fetched_resource[:id])
      record.update(send("#{resource}_params", fetched_resource))
    end

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
  end
end
