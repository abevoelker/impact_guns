# -*- encoding: utf-8 -*-
require File.expand_path('../lib/impact_guns/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "impact_guns"
  s.version     = ImpactGuns::VERSION
  s.authors     = ['Abe Voelker']
  s.email       = 'abe@abevoelker.com'
  s.homepage    = 'https://github.com/abevoelker/impact_guns'
  s.summary     = %q{Basic API for accessing http://www.impactguns.com}
  s.description = %q{Basic API for accessing http://www.impactguns.com}
  s.license     = 'MIT'

  s.add_dependency "activemodel",          ">= 3.0"
  s.add_dependency "entasis",              ">= 1.0"
  s.add_dependency "mechanize",            ">= 2.3"
  s.add_dependency "andand"
  s.add_dependency "money",                ">= 5.0"
  s.add_dependency "celluloid",            ">= 0.13"
  s.add_dependency "celluloid-rate_limit", "~> 0.0.1"

  s.add_development_dependency "bundler",    "~> 1.0"
  s.add_development_dependency "rspec",      "~> 2.11"
  s.add_development_dependency "rake",       "~> 0.9"
  s.add_development_dependency "webmock",    "~> 1.11"
  s.add_development_dependency "vcr",        "~> 2.5"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = ['test','spec','features'].map{|d| `git ls-files -- #{d}/*`.split("\n")}.flatten
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
