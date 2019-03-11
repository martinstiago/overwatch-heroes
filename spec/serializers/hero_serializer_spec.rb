# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeroSerializer, type: :serializer do
  let(:hero) { create(:hero) }

  describe '#serialized_json' do
    subject(:hero_hash) { JSON.parse(described_class.new(hero).serialized_json, symbolize_names: true) }

    it { expect(hero_hash[:data][:attributes][:name]).to eq(hero.name) }
    it { expect(hero_hash[:data][:attributes][:real_name]).to eq(hero.real_name) }
    it { expect(hero_hash[:data][:attributes][:health]).to eq(hero.health) }
    it { expect(hero_hash[:data][:attributes][:armour]).to eq(hero.armour) }
    it { expect(hero_hash[:data][:attributes][:shield]).to eq(hero.shield) }
  end
end
