# frozen_string_literal: true

class Hero
  include Mongoid::Document

  field :source_id, type: Integer
  field :name, type: String
  field :real_name, type: String
  field :health, type: Integer
  field :armour, type: Integer
  field :shield, type: Integer

  has_many :abilities, dependent: :delete_all
end
