require 'rake'
require 'onixo/rake_helper'

namespace :onixo do
  desc 'Split ONIX file into separate files'
  task :split, [:file, :row, :output] => :environment do |_task, args|
    file = args["file"]
    row = args["row"].to_i
    output = args["output"]
    raise "Supply a file" if file.nil?
    raise "Supply a number of row to splitted" if row.nil?
    raise "Supply an output" if output.nil?

    Onixo::RakeHelper.truncate_to_multiple(file: file, row: row, output: output)
  end

  # desc 'Resets data for the specified indexes or all of them only if the index specification is changed'
  # task converter: :environment do |_task, args|
  #   Onixo::RakeHelper.converter(args)
  # end
end
