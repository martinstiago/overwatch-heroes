# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::HeroesController, type: :controller do
  describe '#index' do
    subject(:heroes) { create_list(:hero, 4) }

    before { get :index }

    it { expect(JSON.parse(response.body)[:data]).to eq(JSON.parse(HeroSerializer.new(heroes).serialized_json)[:data]) }
  end

  describe '#show' do
    subject(:hero) { create(:hero) }

    before { get :show, params: { id: hero.id } }

    it { expect(JSON.parse(response.body)[:data]).to eq(JSON.parse(HeroSerializer.new(hero).serialized_json)[:data]) }
  end

  describe '#abilities' do
    subject(:abilities) { hero.abilities }

    let(:hero) { create(:hero) }

    before { get :abilities, params: { id: hero.id } }

    it { expect(JSON.parse(response.body)[:data]).to eq(JSON.parse(AbilitySerializer.new(abilities).serialized_json)[:data]) }
  end
end
