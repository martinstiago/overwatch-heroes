# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PersistanceService, type: :service do
  let(:heroes_url) { 'https://overwatch-api.net/api/v1/hero' }
  let(:abilities_url) { 'https://overwatch-api.net/api/v1/ability' }
  let(:abilities_url_page2) { 'https://overwatch-api.net/api/v1/ability?page=2' }

  let(:hero1) { build(:hero, source_id: 1) }
  let(:hero2) { build(:hero, source_id: 2) }

  let(:ability1) { build(:ability, source_id: 1) }
  let(:ability2) { build(:ability, source_id: 2) }
  let(:ability3) { build(:ability, source_id: 3) }

  let(:heroes_json) do
    {
      total: 2,
      first: 'http://overwatch-api.net/api/v1/hero?page=1',
      next: nil,
      previous: nil,
      last: 'http://overwatch-api.net/api/v1/hero?page=1',
      data: [
        {
          id: hero1.source_id,
          name: hero1.name,
          health: hero1.health,
          armour: hero1.armour,
          shield: hero1.shield,
          real_name: hero1.real_name
        },
        {
          id: hero2.source_id,
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
          id: ability1.source_id,
          name: ability1.name,
          description: ability1.description,
          is_ultimate: ability1.is_ultimate,
          hero: { id: 1 }
        },
        {
          id: ability2.source_id,
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
          id: ability3.source_id,
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

    describe 'assigment check' do
      before { persister.persist }

      describe 'heroes' do
        subject(:persisted_heroes) { Hero.where(source_id: { '$in': [hero1.source_id, hero2.source_id] }) }

        it { expect(persisted_heroes.pluck(:name)).to match_array([hero1.name, hero2.name]) }
        it { expect(persisted_heroes.pluck(:health)).to match_array([hero1.health, hero2.health]) }
        it { expect(persisted_heroes.pluck(:armour)).to match_array([hero1.armour, hero2.armour]) }
        it { expect(persisted_heroes.pluck(:shield)).to match_array([hero1.shield, hero2.shield]) }
        it { expect(persisted_heroes.pluck(:real_name)).to match_array([hero1.real_name, hero2.real_name]) }
      end

      describe 'abilities' do
        subject(:persisted_abilities) { Ability.where(source_id: { '$in': [ability1.source_id, ability2.source_id, ability3.source_id] }) }

        it { expect(persisted_abilities.pluck(:name)).to match_array([ability1.name, ability2.name, ability3.name]) }
        it { expect(persisted_abilities.pluck(:description)).to match_array([ability1.description, ability2.description, ability3.description]) }
        it { expect(persisted_abilities.pluck(:is_ultimate)).to match_array([ability1.is_ultimate, ability2.is_ultimate, ability3.is_ultimate]) }

        it { expect(persisted_abilities.first.hero.source_id).to eq(hero1.source_id) }
        it { expect(persisted_abilities.second.hero.source_id).to eq(hero1.source_id) }
        it { expect(persisted_abilities.last.hero.source_id).to eq(hero1.source_id) }
      end
    end
  end
end
