# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant/networkadapter/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-networkadapter"
  spec.version       = Vagrant::NetworkAdapter::VERSION
  spec.authors       = ["Jérôme Martin"]
  spec.email         = ["jerome.f.martin@gmail.com"]

  spec.summary       = %q{Vagrant plugin to add Hyper-V network adapter}
  spec.description   = %q{Vagrant plugin to add Hyper-V network adapter at creation time}
  spec.homepage      = "https://github.com/jeromemartin/vagrant-networkadapter"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files += Dir['lib/vagrant/*']
  spec.files += Dir['lib/vagrant/networkadapter/scripts/*']

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end