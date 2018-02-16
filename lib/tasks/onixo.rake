require 'onixo/rake_helper'

def parse_classes(args)
  if args.present? && args.first.tr!('-', '')
    {except: args}
  else
    {only: args}
  end
end

def parse_parallel_args(args)
  options = {}
  options[:parallel] = args.first =~ /\A\d+\z/ ? Integer(args.shift) : true
  options.merge!(parse_classes(args))
end

def parse_journal_args(args)
  options = {}
  options[:time] = Time.parse(args.shift) if args.first =~ /\A\d+/
  options.merge!(parse_classes(args))
end

namespace :onixo do
  desc 'Destroys, recreates and imports data for the specified indexes or all of them'
  task split: :environment do |_task, args|
    Onixo::RakeHelper.split(parse_classes(args.extras))
  end

  desc 'Resets data for the specified indexes or all of them only if the index specification is changed'
  task converter: :environment do |_task, args|
    Onixo::RakeHelper.converter(parse_classes(args.extras))
  end
end
