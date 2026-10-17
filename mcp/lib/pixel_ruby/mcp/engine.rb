# frozen_string_literal: true
require "rails/engine"

module PixelRuby
  module MCP
    class Engine < ::Rails::Engine
      isolate_namespace PixelRuby::MCP

      initializer "pixel_ruby.mcp.eager_load_rack_app", after: :load_config_initializers do
        require "pixel_ruby/mcp/rack_app"
      end
    end
  end
end
