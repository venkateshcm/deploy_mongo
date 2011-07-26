# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deploy_mongo/version"

Gem::Specification.new do |s|
  s.name        = "deploy_mongo"
  s.version     = DeployMongo::VERSION
  s.authors     = ["venky/mln"]
  s.email       = ["venkatesh.swdev@gmail.com"]
  s.homepage    = "https://github.com/venkateshcm/deploy_mongo"
  s.summary     = "dbDeploy for couchdb"
  s.description = "dbDeploy for couchdb"

  s.rubyforge_project = "deploy_mongo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
