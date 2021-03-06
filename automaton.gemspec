# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'automaton/version'

Gem::Specification.new do |spec|
  spec.name          = "automaton"
  spec.version       = Automaton::VERSION
  spec.authors       = ["Marc Lee"]
  spec.email         = ["marc@adviso.com.au"]
  spec.description   = %q{Locomote Test}
  spec.summary       = %q{Locomote robotic automation. }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'highline'
  spec.add_runtime_dependency 'cli-console'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "ZenTest"
  spec.add_development_dependency "shoulda"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "awesome_print"

end
