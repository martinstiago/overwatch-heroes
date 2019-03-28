# frozen_string_literal: true

namespace :persist do
  task heroes: :environment do
    PersistanceService.new.persist
  end
end
