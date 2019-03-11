# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heroes::PersistanceService, type: :service do
  let(:heroes_url) { 'https://overwatch-api.net/api/v1/hero' }
  let(:abilities_url) { 'https://overwatch-api.net/api/v1/ability' }
  let(:abilities_url_page2) { 'https://overwatch-api.net/api/v1/ability?page=2' }

  let(:hero1) { build(:hero) }
  let(:hero2) { build(:hero) }

  let(:ability1) { build(:ability) }
  let(:ability2) { build(:ability) }
  let(:ability3) { build(:ability) }

  let(:heroes_json) do
    {
      total: 2,
      first: 'http://overwatch-api.net/api/v1/hero?page=1',
      next: nil,
      previous: nil,
      last: 'http://overwatch-api.net/api/v1/hero?page=1',
      data: [
        {
          id: 1,
          name: hero1.name,
          health: hero1.health,
          armour: hero1.armour,
          shield: hero1.shield,
          real_name: hero1.real_name
        },
        {
          id: 2,
          name: hero2.name,
          health: hero2.health,
          armour: hero2.armour,
          shield: hero2.shield,
          real_name: hero2.real_name
        }
      ]
    }.to_json
  end

  let(:abilities_json_page1) do
    {
      total: 3,
      first: 'http://overwatch-api.net/api/v1/hero?page=1',
      next: 'http://overwatch-api.net/api/v1/ability?page=2',
      previous: nil,
      last: 'http://overwatch-api.net/api/v1/ability?page=2',
      data: [
        {
          id: 1,
          name: ability1.name,
          description: ability1.description,
          is_ultimate: ability1.is_ultimate,
          hero: { id: 1 }
        },
        {
          id: 2,
          name: ability2.name,
          description: ability2.description,
          is_ultimate: ability2.is_ultimate,
          hero: { id: 1 }
        }
      ]
    }.to_json
  end

  let(:abilities_json_page2) do
    {
      total: 3,
      first: 'http://overwatch-api.net/api/v1/hero?page=1',
      next: nil,
      previous: 'http://overwatch-api.net/api/v1/hero?page=1',
      last: 'http://overwatch-api.net/api/v1/ability?page=2',
      data: [
        {
          id: 3,
          name: ability3.name,
          description: ability3.description,
          is_ultimate: ability3.is_ultimate,
          hero: { id: 1 }
        }
      ]
    }.to_json
  end

  describe '#persist' do
    subject(:persister) { described_class.new }

    before do
      stub_request(:get, heroes_url).to_return(body: heroes_json)
      stub_request(:get, abilities_url).to_return(body: abilities_json_page1)
      stub_request(:get, abilities_url_page2).to_return(body: abilities_json_page2)
    end

    it { expect { persister.persist }.to change(Hero, :count).from(0).to(2) }
    it { expect { persister.persist }.to change(Ability, :count).from(0).to(3) }
  end
end
