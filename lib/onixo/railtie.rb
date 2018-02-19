module Onixo
  class Railtie < Rails::Railtie
    def self.all_engines
      Rails::Engine.subclasses.map(&:instance) + [Rails.application]
    end

    rake_tasks do
      load 'tasks/onixo.rake'
    end

  end
end
