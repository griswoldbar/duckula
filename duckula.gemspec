# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duckula/version'

Gem::Specification.new do |spec|
  spec.name          = "duckula"
  spec.version       = Duckula::VERSION
  spec.authors       = ["Christopher Turtle"]
  spec.email         = ["turtle@cantab.net"]

  spec.summary       = %q{Docker Compose wrapper for updating and running services still in active development}
  spec.homepage      = "https://github.com/griswoldbar/duckula"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['duckula', 'duckula-reloader']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
