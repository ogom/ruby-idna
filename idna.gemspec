# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "idna/version"

Gem::Specification.new do |spec|
  spec.name          = "idna"
  spec.version       = Idna::VERSION
  spec.authors       = ["ogom", "RIP Global"]
  spec.email         = ["ogom@outlook.com", "dev@ripglobal.com"]

  spec.summary       = %q{Ruby FFI bindings for Libidn2.}
  spec.description   = %q{Ruby FFI bindings for Libidn2.}
  spec.homepage      = "https://github.com/ogom/ruby-idna"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ffi"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.0"
end
