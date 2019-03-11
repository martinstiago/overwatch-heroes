# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hero, type: :model do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_field(:source_id).of_type(Integer) }
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:real_name).of_type(String) }
  it { is_expected.to have_field(:health).of_type(Integer) }
  it { is_expected.to have_field(:armour).of_type(Integer) }
  it { is_expected.to have_field(:shield).of_type(Integer) }

  it { is_expected.to have_many(:abilities).with_dependent(:delete_all) }
end
