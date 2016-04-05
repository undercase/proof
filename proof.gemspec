$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "proof/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "proof-rails"
  s.version     = Proof::VERSION
  s.authors     = ["Thomas Hobohm"]
  s.email       = ["superman3275@gmail.com"]
  s.homepage    = "https://github.com/superman3275/proof"
  s.summary     = "Authentication for modern web apps."
  s.description = "Proof provides an easy-to-use JWT-based authentication system."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rake"
  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "jwt", "~> 1.5.1"

  s.add_development_dependency "sqlite3"
end
