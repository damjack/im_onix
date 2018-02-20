require 'onixo/rake_helper'

namespace :onixo do
  desc 'Destroys, recreates and imports data for the specified indexes or all of them'
  task :split, [:file, :row, :output] do |_task, args|
    Onixo::RakeHelper.truncate_to_multiple(args)
  end

  # desc 'Resets data for the specified indexes or all of them only if the index specification is changed'
  # task converter: :environment do |_task, args|
  #   Onixo::RakeHelper.converter(args)
  # end
end
