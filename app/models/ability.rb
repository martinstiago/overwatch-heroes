# frozen_string_literal: true

class Ability
  include Mongoid::Document

  field :source_id, type: Integer
  field :name, type: String
  field :description, type: String
  field :is_ultimate, type: Boolean

  belongs_to :hero, index: true
end
