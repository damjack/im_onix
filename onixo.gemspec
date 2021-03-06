# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onixo/version'

Gem::Specification.new do |spec|
  spec.name            = "onixo"
  spec.version         = Onixo::VERSION
  spec.authors         = ["Damiano Giacomello"]
  spec.email           = ["giacomello.damiano@gmail.com"]
  spec.homepage        = "http://github.com/damjack/onixo"
  spec.summary         = "ONIX V3/2.1 parser"
  spec.description     = "ONIX V3/2.1 parser"

  spec.files           = `git ls-files`.split($/)
  spec.executables     = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files      = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths   = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'nokogiri'
  spec.add_dependency 'activesupport', '>= 4.0'
end
