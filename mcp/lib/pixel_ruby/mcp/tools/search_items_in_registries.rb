# frozen_string_literal: true

require "pixel_ruby/mcp/tools/base"

module PixelRuby
  module MCP
    module Tools
      class SearchItemsInRegistries < Base
        def call(query:, limit: 10, **)
          {items: @registry.search(query, limit: limit), gem_version: gem_version}
        end
      end
    end
  end
end
