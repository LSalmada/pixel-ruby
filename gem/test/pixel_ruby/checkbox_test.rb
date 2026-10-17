# frozen_string_literal: true

require "test_helper"

class PixelRuby::CheckboxTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Checkbox(id: "terms")
    end

    assert_match(/terms/, output)
  end
end
