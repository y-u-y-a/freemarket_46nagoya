# -*- encoding: utf-8 -*-
# stub: rails-i18n 5.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-i18n"
  s.version = "5.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Rails I18n Group"]
  s.date = "2019-01-28"
  s.description = "A set of common locale data and translations to internationalize and/or localize your Rails applications."
  s.email = "rails-i18n@googlegroups.com"
  s.homepage = "http://github.com/svenfuchs/rails-i18n"
  s.licenses = ["MIT"]
  s.rubyforge_project = "[none]"
  s.rubygems_version = "2.5.1"
  s.summary = "Common locale data and translations for Rails i18n."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<i18n>, ["< 2", ">= 0.7"])
      s.add_runtime_dependency(%q<railties>, ["< 6", ">= 5.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 3.7"])
      s.add_development_dependency(%q<i18n-spec>, ["~> 0.6.0"])
      s.add_development_dependency(%q<i18n-tasks>, ["~> 0.9.20"])
    else
      s.add_dependency(%q<i18n>, ["< 2", ">= 0.7"])
      s.add_dependency(%q<railties>, ["< 6", ">= 5.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 3.7"])
      s.add_dependency(%q<i18n-spec>, ["~> 0.6.0"])
      s.add_dependency(%q<i18n-tasks>, ["~> 0.9.20"])
    end
  else
    s.add_dependency(%q<i18n>, ["< 2", ">= 0.7"])
    s.add_dependency(%q<railties>, ["< 6", ">= 5.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 3.7"])
    s.add_dependency(%q<i18n-spec>, ["~> 0.6.0"])
    s.add_dependency(%q<i18n-tasks>, ["~> 0.9.20"])
  end
end
