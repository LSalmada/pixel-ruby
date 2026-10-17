# frozen_string_literal: true

require "test_helper"

class PixelRuby::AlertTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Alert do
        PixelRuby.AlertTitle { "Pro tip" }
        PixelRuby.AlertDescription { "Simply, don't include an icon and your alert will look like this." }
      end
    end

    assert_match(/Pro tip/, output)
  end
end
