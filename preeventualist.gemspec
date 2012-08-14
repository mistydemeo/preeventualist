# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "preeventualist"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Misty De Meo"]
  s.email       = ["mistydemeo@gmail.com"]
  s.homepage    = "https://github.com/mistydemeo/preeventualist"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["."]

  s.add_runtime_dependency "sinatra"
  s.add_runtime_dependency "sinatra-activerecord"
  s.add_runtime_dependency "activerecord"
  s.add_runtime_dependency "sqlite3"
  s.add_runtime_dependency "foreigner"

  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"
  s.add_development_dependency "capybara"
end
