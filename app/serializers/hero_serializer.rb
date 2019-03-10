# frozen_string_literal: true

class HeroSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :real_name, :health, :armor, :shield
  has_many :abilities
end
