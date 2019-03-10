# frozen_string_literal: true

module Api
  class HeroesController < ApplicationController
    before_action :find_hero, only: %i[show abilities]

    def index
      @heroes = Hero.all
      render json: HeroSerializer.new(@heroes).serialized_json
    end

    def show
      render json: HeroSerializer.new(@hero).serialized_json
    end

    def abilities
      render json: AbilitySerializer.new(@hero.abilities).serialized_json
    end

    private

    def find_hero
      @hero = Hero.find(params[:id])
    end
  end
end
