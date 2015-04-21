# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef/development/version'

Gem::Specification.new do |spec|
  spec.name          = "chef-development"
  spec.version       = Chef::Development::VERSION
  spec.authors       = ["jpount"]
  spec.email         = ["johnpount@gmail.com"]

  spec.summary       = %q{Chef cookbook development}
  spec.description   = %q{Chef cookbook development}
  spec.homepage      = "https://github.com/jpount"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/jpount"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency 'berkshelf', '~>3.1'
  spec.add_dependency 'chef', '~> 11.6'
  spec.add_dependency 'chefspec', '~> 4.2'
  spec.add_dependency 'knife-ec2', '~> 0.10'
  spec.add_dependency 'foodcritic', '~> 3.0'
  spec.add_dependency 'kitchen-vagrant', '~> 0.11'
  spec.add_dependency 'test-kitchen'
  spec.add_dependency 'version', '~> 1.0'
  spec.add_dependency 'thor-scmversion', '~> 1.4.0'
  spec.add_dependency 'kitchen-docker-api', '~> 0.1'
  spec.add_dependency 'semverse', '~> 1.1.0'
  spec.add_dependency 'ridley', '~> 4.1'
  spec.add_dependency 'rspec-its'
  spec.add_dependency "rspec", "~> 3.2"
  spec.add_dependency "rubocop", "~> 0.30.0"
  spec.add_dependency "vagrant-wrapper", "~> 2.0.2"
  spec.add_dependency "gem-release", "~> 0.7.3"

end
