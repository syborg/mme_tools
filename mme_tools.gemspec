# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: mme_tools 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mme_tools"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Marcel Massana"]
  s.date = "2014-04-03"
  s.description = "generic classes and methods that may be used everywhere"
  s.email = "xaxaupua@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "examples/demo_args_proc.rb",
    "examples/demo_config.rb",
    "examples/demo_enumerable.rb",
    "examples/demo_print_debug.rb",
    "examples/demo_webparse.rb",
    "examples/tmp/config.yml",
    "lib/mme_tools.rb",
    "lib/mme_tools/args_proc.rb",
    "lib/mme_tools/concurrent.rb",
    "lib/mme_tools/config.rb",
    "lib/mme_tools/debug.rb",
    "lib/mme_tools/enumerable.rb",
    "lib/mme_tools/version.rb",
    "lib/mme_tools/webparse.rb",
    "mme_tools.gemspec",
    "test/test_config.rb",
    "test/test_enumerable.rb",
    "test/test_webparse.rb"
  ]
  s.homepage = "http://github.com/syborg/mme_tools"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.1"
  s.summary = "various homeless methods"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<unicode>, [">= 0"])
      s.add_runtime_dependency(%q<iconv>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 5.0.0"])
    else
      s.add_dependency(%q<unicode>, [">= 0"])
      s.add_dependency(%q<iconv>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 5.0.0"])
    end
  else
    s.add_dependency(%q<unicode>, [">= 0"])
    s.add_dependency(%q<iconv>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 5.0.0"])
  end
end

