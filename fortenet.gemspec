# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fortenet/version'

Gem::Specification.new do |spec|
  spec.name          = "fortenet"
  spec.version       = Fortenet::VERSION
  spec.authors       = ["Iwo Dziechciarow"]
  spec.email         = ["iiwo@o2.pl"]
  spec.summary       = %q{Simple wrapper for Forte.net REST API}
  spec.description   = %q{Simple wrapper for Forte.net REST API (work in progress) }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'httparty'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
