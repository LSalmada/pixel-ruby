# frozen_string_literal: true

require "pixel_ruby/mcp/tools/base"

module PixelRuby
  module MCP
    module Tools
      class GetProjectRegistries < Base
        def call(**)
          {
            registries: [{
              name: "pixel_ruby",
              url: "https://www.rubyui.com/mcp",
              description: "Pixel Ruby components for Phlex + Rails."
            }]
          }
        end
      end
    end
  end
end
