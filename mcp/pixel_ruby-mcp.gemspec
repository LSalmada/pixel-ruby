require_relative "lib/pixel_ruby/mcp/version"

Gem::Specification.new do |spec|
  spec.name = "pixel_ruby-mcp"
  spec.version = PixelRuby::MCP::VERSION
  spec.authors = ["Pixel Ruby"]
  spec.summary = "MCP server for pixel_ruby — agent-driven component discovery and install."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3"

  spec.files = Dir["lib/**/*", "data/**/*", "exe/*", "README.md", "LICENSE"]
  spec.bindir = "exe"
  spec.executables = ["pixel-ruby-mcp-build"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 8.0"
  spec.add_dependency "mcp", ">= 0.1"
  spec.add_dependency "rack-attack", ">= 6.7"
  spec.add_dependency "reverse_markdown", ">= 2.1"

  spec.add_development_dependency "minitest", ">= 5.0"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "rake"
end
