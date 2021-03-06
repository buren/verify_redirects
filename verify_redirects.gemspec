# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'verify_redirects/version'

Gem::Specification.new do |spec|
  spec.name          = 'verify_redirects'
  spec.version       = VerifyRedirects::VERSION
  spec.authors       = ['Jacob Burenstam']
  spec.email         = ['burenstam@gmail.com']

  spec.summary       = 'Verify HTTP redirects.'
  spec.description   = 'Verify HTTP redirects - comes with CLI and CSV support (you can of course use plain Ruby too).'
  spec.homepage      = 'https://github.com/buren/verify_redirects'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'honey_format', '~> 0.18'
  spec.add_dependency 'http', '~> 3.3'

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
