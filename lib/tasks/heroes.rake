# frozen_string_literal: true

namespace :heroes do
  task persist: :environment do
    PersistanceService.new.persist
  end
end
