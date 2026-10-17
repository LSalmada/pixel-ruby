# frozen_string_literal: true

require "pixel_ruby/mcp/tools/base"

module PixelRuby
  module MCP
    module Tools
      class ListItemsInRegistries < Base
        def call(**)
          {items: @registry.list, gem_version: gem_version}
        end
      end
    end
  end
end
