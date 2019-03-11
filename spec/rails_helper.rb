# frozen_string_literal: true

require 'spec_helper'
require 'rails/mongoid'
require 'mongoid-rspec'
require 'webmock/rspec'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Mongoid::Matchers, type: :model
  config.include FactoryBot::Syntax::Methods
end
