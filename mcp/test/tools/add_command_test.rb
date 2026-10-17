# frozen_string_literal: true

require "test_helper"
require "pixel_ruby/mcp/tools/get_add_command_for_items"

class AddCommandToolTest < Minitest::Test
  def setup
    @registry = PixelRuby::MCP::Registry.load(TestSupport::FIXTURE_PATH)
    @tool = PixelRuby::MCP::Tools::GetAddCommandForItems.new(registry: @registry)
  end

  def test_returns_structured_and_string_form
    result = @tool.call(items: ["Button", "Dialog"])
    assert_equal "pixel_ruby:component", result[:generator]
    assert_equal ["Button", "Dialog"], result[:components]
    assert_equal "rails g pixel_ruby:component Button Dialog", result[:command_string]
  end

  def test_filters_unknown_names
    result = @tool.call(items: ["Button", "Bogus"])
    assert_equal ["Button"], result[:components]
    assert_equal ["Bogus"], result[:unresolved]
  end

  def test_rejects_shell_metachars
    result = @tool.call(items: ["Button; rm -rf /"])
    assert_empty result[:components]
    refute_match(/rm/, result[:command_string])
  end
end
