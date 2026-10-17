# frozen_string_literal: true

require "test_helper"

class PixelRuby::TooltipTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Tooltip do
        PixelRuby.TooltipTrigger do
          PixelRuby.Button(variant: :outline, icon: true) { "?" }
        end
        PixelRuby.TooltipContent do
          PixelRuby::Text(as: "p") { "Add to library" }
        end
      end
    end

    assert_match(/Add to library/, output)
  end

  def test_tooltip_content_wraps_long_text_within_viewport
    output = phlex do
      PixelRuby.TooltipContent { "Long tooltip content" }
    end

    assert_match(/w-fit/, output)
    assert_match(/max-w-\[calc\(100vw-2rem\)\]/, output)
    assert_match(/break-words/, output)
  end
end
