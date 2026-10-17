# frozen_string_literal: true

require "pixel_ruby/mcp/tools/base"

module PixelRuby
  module MCP
    module Tools
      class GetInstallCommandForProject < Base
        def call(**)
          {
            steps: [
              {title: "Add the gem", command: "bundle add pixel_ruby"},
              {title: "Run the installer", command: "bin/rails g pixel_ruby:install"},
              {title: "Add a component", command: "bin/rails g pixel_ruby:component Button"}
            ],
            note: "Use `get_add_command_for_items` once you know which components to install."
          }
        end
      end
    end
  end
end
