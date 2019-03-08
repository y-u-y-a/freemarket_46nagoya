# -*- encoding: utf-8 -*-
# stub: capybara 3.14.0 ruby lib

Gem::Specification.new do |s|
  s.name = "capybara"
  s.version = "3.14.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/teamcapybara/capybara/blob/master/History.md", "source_code_uri" => "https://github.com/teamcapybara/capybara" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["Thomas Walpole", "Jonas Nicklas"]
  s.cert_chain = ["gem-public_cert.pem"]
  s.date = "2019-02-25"
  s.description = "Capybara is an integration testing tool for rack based web applications. It simulates how a user would interact with a website"
  s.email = ["twalpole@gmail.com", "jonas.nicklas@gmail.com"]
  s.homepage = "https://github.com/teamcapybara/capybara"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Capybara aims to simplify the process of integration testing Rack applications, such as Rails, Sinatra or Merb"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>, [">= 0"])
      s.add_runtime_dependency(%q<mini_mime>, [">= 0.1.3"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.8"])
      s.add_runtime_dependency(%q<rack>, [">= 1.6.0"])
      s.add_runtime_dependency(%q<rack-test>, [">= 0.6.3"])
      s.add_runtime_dependency(%q<regexp_parser>, ["~> 1.2"])
      s.add_runtime_dependency(%q<xpath>, ["~> 3.2"])
      s.add_development_dependency(%q<byebug>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 2.3.0"])
      s.add_development_dependency(%q<erubi>, [">= 0"])
      s.add_development_dependency(%q<fuubar>, [">= 1.0.0"])
      s.add_development_dependency(%q<irb>, [">= 0"])
      s.add_development_dependency(%q<launchy>, [">= 2.0.4"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<puma>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 3.5.0"])
      s.add_development_dependency(%q<rubocop>, [">= 0"])
      s.add_development_dependency(%q<rubocop-rspec>, [">= 0"])
      s.add_development_dependency(%q<selenium-webdriver>, ["~> 3.5"])
      s.add_development_dependency(%q<selenium_statistics>, [">= 0"])
      s.add_development_dependency(%q<sinatra>, [">= 1.4.0"])
      s.add_development_dependency(%q<yard>, [">= 0.9.0"])
    else
      s.add_dependency(%q<addressable>, [">= 0"])
      s.add_dependency(%q<mini_mime>, [">= 0.1.3"])
      s.add_dependency(%q<nokogiri>, ["~> 1.8"])
      s.add_dependency(%q<rack>, [">= 1.6.0"])
      s.add_dependency(%q<rack-test>, [">= 0.6.3"])
      s.add_dependency(%q<regexp_parser>, ["~> 1.2"])
      s.add_dependency(%q<xpath>, ["~> 3.2"])
      s.add_dependency(%q<byebug>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 2.3.0"])
      s.add_dependency(%q<erubi>, [">= 0"])
      s.add_dependency(%q<fuubar>, [">= 1.0.0"])
      s.add_dependency(%q<irb>, [">= 0"])
      s.add_dependency(%q<launchy>, [">= 2.0.4"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<puma>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 3.5.0"])
      s.add_dependency(%q<rubocop>, [">= 0"])
      s.add_dependency(%q<rubocop-rspec>, [">= 0"])
      s.add_dependency(%q<selenium-webdriver>, ["~> 3.5"])
      s.add_dependency(%q<selenium_statistics>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 1.4.0"])
      s.add_dependency(%q<yard>, [">= 0.9.0"])
    end
  else
    s.add_dependency(%q<addressable>, [">= 0"])
    s.add_dependency(%q<mini_mime>, [">= 0.1.3"])
    s.add_dependency(%q<nokogiri>, ["~> 1.8"])
    s.add_dependency(%q<rack>, [">= 1.6.0"])
    s.add_dependency(%q<rack-test>, [">= 0.6.3"])
    s.add_dependency(%q<regexp_parser>, ["~> 1.2"])
    s.add_dependency(%q<xpath>, ["~> 3.2"])
    s.add_dependency(%q<byebug>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 2.3.0"])
    s.add_dependency(%q<erubi>, [">= 0"])
    s.add_dependency(%q<fuubar>, [">= 1.0.0"])
    s.add_dependency(%q<irb>, [">= 0"])
    s.add_dependency(%q<launchy>, [">= 2.0.4"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<puma>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 3.5.0"])
    s.add_dependency(%q<rubocop>, [">= 0"])
    s.add_dependency(%q<rubocop-rspec>, [">= 0"])
    s.add_dependency(%q<selenium-webdriver>, ["~> 3.5"])
    s.add_dependency(%q<selenium_statistics>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 1.4.0"])
    s.add_dependency(%q<yard>, [">= 0.9.0"])
  end
end
