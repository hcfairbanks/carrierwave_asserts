
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "carrierwave_asserts/version"

Gem::Specification.new do |spec|
  spec.name          = "carrierwave_asserts"
  spec.version       = CarrierwaveAsserts::VERSION
  spec.authors       = ["Harry"]
  spec.email         = ["hcfairbanks@gmail.com"]

  spec.summary       = %q{Minitest  asserts for carrierwave}
  spec.description   = %q{These asserts model the rspec helpers for carrierwave. See the readme file for more details}
  spec.homepage      = "https://github.com/hcfairbanks/carrierwave_asserts"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"

end
