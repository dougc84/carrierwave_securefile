# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "carrierwave_securefile"
  s.version = "0.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Doug Clark"]
  s.date = "2012-09-14"
  s.description = "Secure, encrypted file uploads using Crypt19 and CarrierWave"
  s.email = "doug@dougclarkonline.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "Icon\r",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "carrierwave_securefile.gemspec",
    "lib/carrierwave/securefile.rb",
    "lib/carrierwave/securefile/aes_file.rb",
    "lib/carrierwave/securefile/configuration.rb",
    "lib/carrierwave/securefile/downloader.rb",
    "lib/carrierwave/securefile/uploader.rb",
    "lib/carrierwave_securefile.rb",
    "test/helper.rb",
    "test/test_carrierwave_securefile.rb"
  ]
  s.homepage = "http://github.com/dougc84/carrierwave_securefile"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Secure, encrypted file uploads using Crypt19 and CarrierWave"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<carrierwave>, [">= 0.5.8"])
      s.add_runtime_dependency(%q<crypt19-rb>, ["= 1.2.1"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<carrierwave>, [">= 0.5.8"])
      s.add_dependency(%q<crypt19-rb>, ["= 1.2.1"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<carrierwave>, [">= 0.5.8"])
    s.add_dependency(%q<crypt19-rb>, ["= 1.2.1"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

