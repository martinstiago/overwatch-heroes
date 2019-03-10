# frozen_string_literal: true

class AbilitySerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :description, :is_ultimate
end
