# frozen_string_literal: true

require "test_helper"

class PixelRuby::BadgeTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Badge { "Badge" }
    end

    assert_match(/Badge/, output)
  end
end
