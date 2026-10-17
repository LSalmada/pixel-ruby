require "test_helper"
require "pixel_ruby/mcp/tools/get_install_command_for_project"

class InstallCommandToolTest < Minitest::Test
  def test_returns_install_steps
    tool = PixelRuby::MCP::Tools::GetInstallCommandForProject.new(registry: nil)
    result = tool.call
    assert_equal 3, result[:steps].length
    assert_match(/bundle add pixel_ruby/, result[:steps].first[:command])
  end
end
