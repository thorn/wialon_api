# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wialon_api/version'

Gem::Specification.new do |spec|
  spec.name          = "wialon_api"
  spec.version       = WialonApi::VERSION
  spec.authors       = ["Arsen Shamkhalov"]
  spec.email         = ["thornu731@gmail.com"]
  spec.summary       = %q{Simple to use WialonPro API client. http://sdk.wialon.com/wiki/ru/pro/pro}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/thorn/wialon_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard-rspec'
end
