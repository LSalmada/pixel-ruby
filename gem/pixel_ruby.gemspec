require_relative "lib/pixel_ruby"

Gem::Specification.new do |s|
  s.name = "pixel_ruby"
  s.version = PixelRuby::VERSION
  s.summary = "PixelRuby is a UI Component Library for Ruby developers."
  s.description = "Pixel Ruby is a UI Component Library for Ruby developers. Built on top of the Phlex Framework."
  s.authors = ["George Kettle"]
  s.email = "george.kettle@icloud.com"
  s.files = Dir["README.md", "LICENSE.txt", "lib/**/*"]
  s.require_path = "lib"
  s.homepage =
    "https://github.com/LSalmada/pixel-ruby"
  s.license = "MIT"

  s.required_ruby_version = ">= 3.2"

  s.add_development_dependency "phlex", "~> 2.1", ">= 2.1.2"
  s.add_development_dependency "rouge", "~> 5.1.0"
  s.add_development_dependency "tailwind_merge", "~> 1.4"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "standard", "~> 1.0"
  s.add_development_dependency "minitest", "~> 6.0"
end
