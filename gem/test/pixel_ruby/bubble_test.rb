# frozen_string_literal: true

require "test_helper"

class PixelRuby::BubbleTest < ComponentTest
  def test_renders_content
    output = phlex do
      PixelRuby.Bubble do
        PixelRuby.BubbleContent { "Hello" }
      end
    end

    assert_match(/Hello/, output)
    assert_match(/data-slot="bubble"/, output)
    assert_match(/data-slot="bubble-content"/, output)
  end

  def test_default_variant_and_align
    output = phlex { PixelRuby.Bubble { PixelRuby.BubbleContent { "Hi" } } }

    assert_match(/data-variant="default"/, output)
    assert_match(/data-align="start"/, output)
  end

  def test_variant_and_align_attributes
    output = phlex do
      PixelRuby.Bubble(variant: :muted, align: :end) { PixelRuby.BubbleContent { "Hi" } }
    end

    assert_match(/data-variant="muted"/, output)
    assert_match(/data-align="end"/, output)
  end

  def test_reactions_defaults_to_bottom_end
    output = phlex do
      PixelRuby.Bubble do
        PixelRuby.BubbleContent { "Hi" }
        PixelRuby.BubbleReactions { "👍" }
      end
    end

    assert_match(/data-slot="bubble-reactions"/, output)
    assert_match(/data-side="bottom"/, output)
    assert_match(/data-align="end"/, output)
  end

  def test_reactions_side_and_align
    output = phlex do
      PixelRuby.BubbleReactions(side: :top, align: :start) { "🔥" }
    end

    assert_match(/data-side="top"/, output)
    assert_match(/data-align="start"/, output)
  end

  def test_content_renders_as_anchor
    output = phlex do
      PixelRuby.Bubble { PixelRuby.BubbleContent(as: :a, href: "#") { "Open" } }
    end

    assert_match(/<a[^>]*data-slot="bubble-content"[^>]*href="#"/, output)
    assert_match(/Open/, output)
  end

  def test_content_renders_as_button
    output = phlex do
      PixelRuby.Bubble { PixelRuby.BubbleContent(as: :button, type: "button") { "Retry" } }
    end

    assert_match(/<button[^>]*data-slot="bubble-content"/, output)
  end

  def test_group_wraps_bubbles
    output = phlex do
      PixelRuby.BubbleGroup do
        PixelRuby.Bubble { PixelRuby.BubbleContent { "a" } }
        PixelRuby.Bubble { PixelRuby.BubbleContent { "b" } }
      end
    end

    assert_match(/data-slot="bubble-group"/, output)
  end
end
