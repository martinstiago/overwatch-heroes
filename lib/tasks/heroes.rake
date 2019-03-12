# frozen_string_literal: true

namespace :heroes do
  task persist: :environment do
    Heroes::PersistanceService.new.persist
  end
end
