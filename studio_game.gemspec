Gem::Specification.new do |spec|
  spec.name        = "studio_game"
  spec.version     = "1.0.0"
  spec.author      = "iMartzen"
  spec.email       = "gem@martzen.nl"
  spec.summary     = "A simple game to play with friends"
  spec.homepage    = "https://github.com/iMartzen/studio_game"
  spec.license     = "MIT"

  spec.files       = Dir["{bin,lib}/**/*"] + %w[LICENSE README.md]
  spec.executables = ["studio_game"]

  spec.required_ruby_version = ">= 3.2.0"
end