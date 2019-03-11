# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AbilitySerializer, type: :serializer do
  let(:ability) { create(:ability) }

  describe '#serialized_json' do
    subject(:ability_hash) { JSON.parse(described_class.new(ability).serialized_json, symbolize_names: true) }

    it { expect(ability_hash[:data][:attributes][:name]).to eq(ability.name) }
    it { expect(ability_hash[:data][:attributes][:description]).to eq(ability.description) }
    it { expect(ability_hash[:data][:attributes][:is_ultimate]).to eq(ability.is_ultimate) }
  end
end
