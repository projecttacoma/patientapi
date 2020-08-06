# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "hquery-patient-api"
  s.summary = "A javascript library abstraction for dealing with patients in hQuery map reduce functions"
  s.description = "A javascript library abstraction for dealing with patients in hQuery map reduce functions"
  s.email = "tacoma-list@lists.mitre.org"
  s.homepage = "http://github.com/hquery/patient_api"
  s.authors = ["The MITRE Corporation"]
  s.version = '1.1.1'

  s.files = `git ls-files`.split("\n")

  s.add_dependency "sprockets", '>= 2.2', '< 5.0'
  s.add_dependency "coffee-script", "~> 2.4"
  s.add_dependency "uglifier", "~> 2.7"
  s.add_dependency 'tilt', "~> 1.4"
  s.add_dependency "libv8", "~> 3.16.14"
  s.add_dependency "therubyracer", "~> 0.12"
end
