# frozen_string_literal: true

module Api
  class AbilitiesController < ApplicationController
    def index
      @abilities = Ability.all
      render json: AbilitySerializer.new(@abilities).serialized_json
    end

    def show
      @ability = Ability.find(params[:id])
      render json: AbilitySerializer.new(@ability).serialized_json
    end
  end
end
