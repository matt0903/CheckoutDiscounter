# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CheckoutDiscounter/version'

Gem::Specification.new do |spec|
  spec.name          = "CheckoutDiscounter"
  spec.version       = CheckoutDiscounter::VERSION
  spec.authors       = ["Matthew Wright"]
  spec.email         = ["matt@mattwright.io"]
  spec.description   = "A checkout system that allows for promotional offers."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
