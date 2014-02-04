# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "capistrano-twingly"
  spec.version       = '0.1.3'
  spec.authors       = ["Johan Eckerström"]
  spec.email         = ["johan@duh.se"]
  spec.summary       = %q{Capistrano 3 tasks used for Twingly's Ruby deployment}
  spec.description   = %q{Capistrano 3 tasks used for Twingly's Ruby deployment}
  spec.homepage      = "https://github.com/twingly/capistrano-twingly"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.0.1"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
