require 'rake'
require 'onixo/rake_helper'

namespace :onixo do
  desc 'Split ONIX file into separate files'
  task :split, [:file, :row, :output] => :environment do |_task, args|
    Onixo::RakeHelper.truncate_to_multiple(args)
  end

  # desc 'Resets data for the specified indexes or all of them only if the index specification is changed'
  # task converter: :environment do |_task, args|
  #   Onixo::RakeHelper.converter(args)
  # end
end
