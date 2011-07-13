# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "riot-datamapper/version"

Gem::Specification.new do |s|
  s.name        = "riot-datamapper"
  s.version     = Riot::Datamapper::VERSION
  s.authors     = ["Arthur Chiu"]
  s.email       = ["mr.arthur.chiu@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "riot-datamapper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'riot'
  s.add_dependency 'dm-core'
  s.add_dependency 'dm-validations'
end
