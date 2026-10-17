# frozen_string_literal: true

require "test_helper"

class PixelRuby::EmptyTest < ComponentTest
  def test_renders_full_structure
    output = phlex do
      PixelRuby.Empty do
        PixelRuby.EmptyHeader do
          PixelRuby.EmptyMedia(variant: :icon) { "icon" }
          PixelRuby.EmptyTitle { "Nothing here" }
          PixelRuby.EmptyDescription { "No content yet." }
        end
        PixelRuby.EmptyContent { "action" }
      end
    end

    assert_match(/data-slot="empty"/, output)
    assert_match(/data-slot="empty-header"/, output)
    assert_match(/data-slot="empty-icon"/, output)
    assert_match(/data-slot="empty-title"/, output)
    assert_match(/data-slot="empty-description"/, output)
    assert_match(/data-slot="empty-content"/, output)
    assert_match(/Nothing here/, output)
  end

  def test_media_default_variant
    output = phlex { PixelRuby.EmptyMedia { "x" } }

    assert_match(/data-variant="default"/, output)
  end

  def test_media_icon_variant
    output = phlex { PixelRuby.EmptyMedia(variant: :icon) { "x" } }

    assert_match(/data-variant="icon"/, output)
    assert_match(/bg-muted/, output)
  end
end
