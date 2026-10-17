# frozen_string_literal: true

require "test_helper"

class PixelRuby::DataTableExpandToggleTest < ComponentTest
  def test_renders_button_with_aria_attributes_and_delegated_action
    output = phlex { PixelRuby.DataTableExpandToggle(controls: "emp-1-detail") }
    assert_match(/<button[^>]*type="button"/, output)
    assert_match(/aria-expanded="false"/, output)
    assert_match(/aria-controls="emp-1-detail"/, output)
    assert_match(/aria-label="Toggle row details"/, output)
    assert_match(/data-action="[^"]*click->pixel-ruby--data-table#toggleRowDetail/, output)
    refute_match(/data-controller="pixel-ruby--data-table-row-expand"/, output)
  end

  def test_accepts_custom_label_and_initial_expanded_state
    output = phlex { PixelRuby.DataTableExpandToggle(controls: "x", expanded: true, label: "Toggle") }
    assert_match(/aria-expanded="true"/, output)
    assert_match(/aria-label="Toggle"/, output)
  end
end
