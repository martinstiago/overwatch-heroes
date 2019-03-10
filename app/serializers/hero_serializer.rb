# frozen_string_literal: true

class HeroSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :real_name, :health, :armour, :shield
  has_many :abilities
end
