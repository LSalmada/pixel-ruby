# frozen_string_literal: true

require "test_helper"

class PixelRuby::DataTableBulkActionsTest < ComponentTest
  def test_starts_hidden_with_bulk_actions_target_and_renders_children
    output = phlex { PixelRuby.DataTableBulkActions { "BUTTONS" } }
    assert_match(/class="[^"]*hidden[^"]*"/, output)
    assert_match(/data-pixel-ruby--data-table-target="bulkActions"/, output)
    assert_match(/BUTTONS/, output)
  end
end
