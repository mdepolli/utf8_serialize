$:.push File.expand_path("../lib", __FILE__)
require "utf8_serialize/version"

Gem::Specification.new do |s|
  s.name          = "utf8_serialize"
  s.version       = UTF8Serialize::VERSION
  s.authors       = ["Drew Blas"]
  s.email         = %q{drew.blas@gmail.com}
  s.summary       = %q{Allows Rails3 + Ruby1.9 to read YAML written by Rails2 + Ruby1.8 (YAML with binary encoded UTF8)}
  s.require_paths = ["lib"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_dependency 'activerecord', '~> 4.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'sqlite3-ruby'
  s.add_development_dependency 'rspec'
end
