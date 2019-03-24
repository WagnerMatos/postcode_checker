lib = File.expand_path('../lib', __FILE__ )
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'postcode_checker/version'

Gem::Specification.new do |spec|
  spec.name         = 'postcode_checker'
  spec.version      = PostcodeChecker::VERSION
  spec.authors      = ['Wagner Matos']
  spec.email        = ['wagner.matos@mac.com']

  spec.summary      = 'Check if a given postcode area is serviceable'
  spec.description  = 'Given a postcode and a config determine whether the
postcode is within a serviceable areas'
  spec.homepage     = 'https://github.com/WagnerMatos/allocator'
  spec.license      = 'MIT'

  spec.required_ruby_version = '~> 2.2'

  # Specify which files should be added to the gem when released
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files          = Dir.chdir(File.expand_path('..', __FILE__ )) do
    `git ls-files -z`.split('\x0').reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir         = 'exe'
  spec.executables    = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths  = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17.2'
  spec.add_development_dependency 'rake', '~> 12.3.2'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_runtime_dependency 'faraday', '0.15.4'
  spec.add_runtime_dependency 'uk_postcode', '2.1.3'
end