# frozen_string_literal: true

class Hero
  include Mongoid::Document

  field :name, type: String
  field :real_name, type: String
  field :health, type: Integer
  field :armor, type: Integer
  field :shield, type: Integer

  has_many :abilities, dependent: :delete_all
end
