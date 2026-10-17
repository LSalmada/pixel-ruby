# frozen_string_literal: true

require "pixel_ruby/mcp/tools/base"

module PixelRuby
  module MCP
    module Tools
      class GetAddCommandForItems < Base
        GENERATOR = "pixel_ruby:component"

        def call(items:, **)
          known, unresolved = @registry.partition_names(Array(items))
          {
            generator: GENERATOR,
            components: known,
            unresolved: unresolved,
            command_string: known.empty? ? "" : "rails g #{GENERATOR} #{known.join(" ")}",
            gem_version: gem_version
          }
        end
      end
    end
  end
end
