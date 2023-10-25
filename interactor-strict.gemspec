require "English"

Gem::Specification.new do |spec|
  spec.name = "interactor-strict"
  spec.version = "1.0.0"

  spec.author = "Marcelo Jacobus"
  spec.email = "marcelo.jacobus@gmail.com"
  spec.description = "Extends the interactor gem"
  spec.summary = "Extends the interactor gem"
  spec.homepage = "https://github.com/mjacobus/interactor-strict"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.test_files = spec.files.grep(/^spec/)

  spec.add_dependency "interactor"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
