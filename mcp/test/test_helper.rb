$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest/autorun"
require "pixel_ruby/mcp/registry"

module TestSupport
  FIXTURE_PATH = File.expand_path("fixtures/registry.json", __dir__)
end
