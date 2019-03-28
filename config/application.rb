# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'action_controller/railtie'

Bundler.require(*Rails.groups)

module OverwatchHeroes
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true
  end
end
