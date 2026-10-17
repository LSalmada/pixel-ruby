# frozen_string_literal: true

require "test_helper"

class PixelRuby::DataTableSelectionSummaryTest < ComponentTest
  def test_renders_selection_count_text_with_target
    output = phlex { PixelRuby.DataTableSelectionSummary(total_on_page: 10) }
    assert_match(/0 of 10 row\(s\) selected\./, output)
    assert_match(/data-pixel-ruby--data-table-target="selectionSummary"/, output)
  end
end
