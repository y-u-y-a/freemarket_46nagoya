# -*- encoding: utf-8 -*-
# stub: warden 1.2.8 ruby lib

Gem::Specification.new do |s|
  s.name = "warden"
  s.version = "1.2.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Daniel Neighman", "Justin Smestad", "Whitney Smestad", "Jos\u{e9} Valim"]
  s.date = "2018-11-15"
  s.email = "hasox.sox@gmail.com justin.smestad@gmail.com whitcolorado@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "https://github.com/hassox/warden"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubyforge_project = "warden"
  s.rubygems_version = "2.5.1"
  s.summary = "An authentication library compatible with all Rack-based frameworks"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 2.0.6"])
    else
      s.add_dependency(%q<rack>, [">= 2.0.6"])
    end
  else
    s.add_dependency(%q<rack>, [">= 2.0.6"])
  end
end
