# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "capistrano-twingly"
  spec.version       = '2.4.1'
  spec.authors       = ["Twingly AB"]
  spec.email         = ["support@twingly.com"]
  spec.summary       = %q{Capistrano 3 tasks used for Twingly's Ruby deployment}
  spec.description   = %q{Capistrano 3 tasks used for Twingly's Ruby deployment}
  spec.homepage      = "https://github.com/twingly/capistrano-twingly"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.6.0"
  spec.add_dependency "capistrano-bundler", "1.1.4"
  spec.add_dependency "capistrano-chruby", "0.1.2"
  spec.add_dependency "foreman", "~> 0.82"
  spec.add_dependency "net-ssh", "~> 5.0"
  spec.add_dependency "ed25519", ">= 1.2", "< 1.3"
  spec.add_dependency "bcrypt_pbkdf", ">= 1.0", "< 2.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rake"
end
