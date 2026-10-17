# frozen_string_literal: true
require "rails"
require "pixel_ruby/mcp/version"
require "pixel_ruby/mcp/engine"

module PixelRuby
  module MCP
    def self.registry
      @registry ||= Registry.load_default
    end

    def self.root
      Engine.root
    end
  end
end
