# frozen_string_literal: true

require "mcp"
require "pixel_ruby/mcp/registry"
require "pixel_ruby/mcp/tools/get_project_registries"
require "pixel_ruby/mcp/tools/list_items_in_registries"
require "pixel_ruby/mcp/tools/search_items_in_registries"
require "pixel_ruby/mcp/tools/view_items_in_registries"
require "pixel_ruby/mcp/tools/get_item_examples_from_registries"
require "pixel_ruby/mcp/tools/get_add_command_for_items"
require "pixel_ruby/mcp/tools/get_audit_checklist"
require "pixel_ruby/mcp/tools/get_install_command_for_project"

module PixelRuby
  module MCP
    class Server
      TOOL_DEFINITIONS = [
        {
          name: "get_project_registries",
          klass: Tools::GetProjectRegistries,
          description: "List available registries. Always returns the pixel_ruby registry.",
          input_schema: {properties: {}}
        },
        {
          name: "list_items_in_registries",
          klass: Tools::ListItemsInRegistries,
          description: "List all Pixel Ruby components with name and description.",
          input_schema: {properties: {}}
        },
        {
          name: "search_items_in_registries",
          klass: Tools::SearchItemsInRegistries,
          description: "Fuzzy search Pixel Ruby components by name, description, or docs.",
          input_schema: {
            properties: {
              query: {type: "string"},
              limit: {type: "integer"}
            },
            required: ["query"]
          }
        },
        {
          name: "view_items_in_registries",
          klass: Tools::ViewItemsInRegistries,
          description: "Return full source files and dependencies for the given components.",
          input_schema: {
            properties: {items: {type: "array", items: {type: "string"}}},
            required: ["items"]
          }
        },
        {
          name: "get_item_examples_from_registries",
          klass: Tools::GetItemExamplesFromRegistries,
          description: "Return code examples for the given components.",
          input_schema: {
            properties: {items: {type: "array", items: {type: "string"}}},
            required: ["items"]
          }
        },
        {
          name: "get_add_command_for_items",
          klass: Tools::GetAddCommandForItems,
          description: "Return a validated `rails g pixel_ruby:component …` command for installing components.",
          input_schema: {
            properties: {items: {type: "array", items: {type: "string"}}},
            required: ["items"]
          }
        },
        {
          name: "get_audit_checklist",
          klass: Tools::GetAuditChecklist,
          description: "Return a post-install verification checklist.",
          input_schema: {properties: {}}
        },
        {
          name: "get_install_command_for_project",
          klass: Tools::GetInstallCommandForProject,
          description: "Return the commands to bootstrap pixel_ruby in a fresh Rails project (gem install + pixel_ruby:install generator).",
          input_schema: {properties: {}}
        }
      ].freeze

      def self.build(registry: PixelRuby::MCP.registry)
        new(registry: registry).mcp_server
      end

      attr_reader :tool_classes

      def initialize(registry:)
        @registry = registry
        @tool_classes = TOOL_DEFINITIONS.map { |d| build_tool_class(d) }
      end

      def mcp_server
        ::MCP::Server.new(
          name: "pixel_ruby",
          version: PixelRuby::MCP::VERSION,
          tools: @tool_classes
        )
      end

      private

      def build_tool_class(definition)
        impl = definition[:klass].new(registry: @registry)
        ::MCP::Tool.define(
          name: definition[:name],
          description: definition[:description],
          input_schema: definition[:input_schema]
        ) do |server_context: nil, **args|
          impl.respond { impl.call(**args) }
        end
      end
    end
  end
end
