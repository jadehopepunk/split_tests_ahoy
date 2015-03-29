$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "split_tests_ahoy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "split_tests_ahoy"
  s.version     = SplitTestsAhoy::VERSION
  s.authors     = ["Craig Ambrose"]
  s.email       = ["craig@enspiral.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SplitTestsAhoy."
  s.description = "TODO: Description of SplitTestsAhoy."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.12.2"
end
