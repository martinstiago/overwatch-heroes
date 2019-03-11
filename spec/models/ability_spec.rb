# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ability, type: :model do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_field(:source_id).of_type(Integer) }
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:description).of_type(String) }
  it { is_expected.to have_field(:is_ultimate).of_type(Mongoid::Boolean) }

  it { is_expected.to belong_to(:hero) }
end
