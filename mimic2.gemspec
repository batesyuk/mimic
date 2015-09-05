# -*- encoding: utf-8 -*-
# stub: mimic2 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mimic2"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Luke Redpath, Nic Jackson"]
  s.date = "2015-08-18"
  s.email = "jackson.nic@gmail.com, luke@lukeredpath.co.uk"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["CHANGES", "LICENSE", "README.md", "Rakefile", "lib/mimic", "lib/mimic.rb", "lib/mimic/api.rb", "lib/mimic/fake_host.rb", "spec"]
  s.homepage = "https://github.com/nicholasjackson/mimic"
  s.rdoc_options = ["--main", "README.md"]
  s.rubygems_version = "2.2.2"
  s.summary = "A Ruby gem for faking external web services for testing, forked version of Luke Redpath's mimic"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<thin>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<plist>, ["~> 3.1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.3.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 2.0.2"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<rest-client>, [">= 0"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<thin>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<plist>, ["~> 3.1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.4.0"])
      s.add_dependency(%q<cucumber>, ["~> 2.0.2"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<thin>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<plist>, ["~> 3.1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.4.0"])
    s.add_dependency(%q<cucumber>, ["~> 2.0.2"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
  end
end
