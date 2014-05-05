# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'event_hub_client/version'

Gem::Specification.new do |spec|
  spec.name          = "event_hub_client"
  spec.version       = EventHubClient::VERSION
  spec.authors       = ["Cheng-Tao Chu"]
  spec.email         = ["chengtao@codecademy.com"]
  spec.summary       = %q{Client for EventHub.}
  spec.description   = %q{More details of EventHub available at http://github.com/Codecademy/EventHubClient.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "typhoeus"
end
