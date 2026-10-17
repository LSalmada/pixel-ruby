# frozen_string_literal: true

require "test_helper"

class PixelRuby::ToggleTest < ComponentTest
  def test_renders_button_unpressed_by_default
    output = phlex { PixelRuby.Toggle { "Bold" } }
    assert_match(/<button[^>]*type="button"/, output)
    assert_match(/aria-pressed="false"/, output)
    assert_match(/data-state="off"/, output)
    assert_match(/Bold/, output)
  end

  def test_renders_pressed_when_pressed_true
    output = phlex { PixelRuby.Toggle(pressed: true) { "Bold" } }
    assert_match(/aria-pressed="true"/, output)
    assert_match(/data-state="on"/, output)
  end

  def test_renders_hidden_input_when_name_present
    output = phlex { PixelRuby.Toggle(name: "bold", value: "1") { "Bold" } }
    assert_match(/<input[^>]*type="hidden"[^>]*name="bold"/, output)
    assert_match(/value=""/, output)
  end

  def test_hidden_input_value_reflects_pressed
    output = phlex { PixelRuby.Toggle(name: "bold", value: "1", pressed: true) { "Bold" } }
    assert_match(/<input[^>]*name="bold"[^>]*value="1"/, output)
  end

  def test_no_hidden_input_when_name_absent
    output = phlex { PixelRuby.Toggle { "Bold" } }
    refute_match(/type="hidden"/, output)
  end

  def test_outline_variant_applies_border_class
    output = phlex { PixelRuby.Toggle(variant: :outline) { "x" } }
    assert_match(/border-input/, output)
  end

  def test_size_sm_applies_h8
    output = phlex { PixelRuby.Toggle(size: :sm) { "x" } }
    assert_match(/h-8/, output)
  end

  def test_size_lg_applies_h10
    output = phlex { PixelRuby.Toggle(size: :lg) { "x" } }
    assert_match(/h-10/, output)
  end

  def test_disabled_sets_attribute
    output = phlex { PixelRuby.Toggle(disabled: true) { "x" } }
    assert_match(/<button[^>]*disabled/, output)
  end

  def test_includes_stimulus_controller_and_action
    output = phlex { PixelRuby.Toggle { "x" } }
    assert_match(/data-controller="[^"]*pixel-ruby--toggle/, output)
    assert_match(/data-action="[^"]*click->pixel-ruby--toggle#toggle/, output)
  end

  def test_includes_stimulus_values
    output = phlex { PixelRuby.Toggle(value: "x", unpressed_value: "y", pressed: true) { "x" } }
    assert_match(/data-pixel-ruby--toggle-pressed-value="true"/, output)
    assert_match(/data-pixel-ruby--toggle-value-value="x"/, output)
    assert_match(/data-pixel-ruby--toggle-unpressed-value-value="y"/, output)
  end
end
