# frozen_string_literal: true

require 'simplecov'

SimpleCov.start('rails') do
  add_group 'Serializers', 'app/serializers'
  add_group 'Services', 'app/services'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before do
    DatabaseCleaner[:mongoid].start
  end

  config.after do
    DatabaseCleaner[:mongoid].clean
  end
end
