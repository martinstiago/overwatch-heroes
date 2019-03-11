# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::AbilitiesController, type: :controller do
  describe '#index' do
    subject(:abilities) { create_list(:ability, 4) }

    before { get :index }

    it { expect(JSON.parse(response.body)[:data]).to eq(JSON.parse(AbilitySerializer.new(abilities).serialized_json)[:data]) }
  end

  describe '#show' do
    subject(:ability) { create(:ability) }

    before { get :show, params: { id: ability.id } }

    it { expect(JSON.parse(response.body)[:data]).to eq(JSON.parse(AbilitySerializer.new(ability).serialized_json)[:data]) }
  end
end
