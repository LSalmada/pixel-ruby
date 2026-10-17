# frozen_string_literal: true

require "test_helper"

class PixelRuby::ThemeToggleTest < ComponentTest
  def test_renders_as_toggle_button
    output = phlex { PixelRuby.ThemeToggle { "icon" } }
    assert_match(/<button[^>]*type="button"/, output)
    assert_match(/aria-pressed=/, output)
  end

  def test_wires_theme_toggle_controller
    output = phlex { PixelRuby.ThemeToggle { "icon" } }
    assert_match(/data-controller="[^"]*pixel-ruby--theme-toggle/, output)
    assert_match(/data-controller="[^"]*pixel-ruby--toggle/, output)
    assert_match(/pixel-ruby--toggle:change->pixel-ruby--theme-toggle#apply/, output)
  end

  def test_block_content_rendered
    output = phlex { PixelRuby.ThemeToggle { "SUN_AND_MOON" } }
    assert_match(/SUN_AND_MOON/, output)
  end
end
