# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onix/book/version'

Gem::Specification.new do |spec|
  spec.name            = "onix-book"
  spec.version         = Onix::Book::VERSION
  spec.authors         = ["Damiano Giacomello"]
  spec.email           = ["giacomello.damiano@gmail.com"]
  spec.homepage        = "http://github.com/damjack/onix-book"
  spec.summary         = "ONIX V2.1 and V3 parser"
  spec.description     = "ONIX V2.1 and V3 parser"

  spec.files           = `git ls-files`.split($/)
  spec.executables     = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files      = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths   = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end

