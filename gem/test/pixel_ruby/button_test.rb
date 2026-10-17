# frozen_string_literal: true

require "test_helper"

class PixelRuby::ButtonTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Button(variant: :primary) { "Primary" }
    end

    assert_match(/Primary/, output)
  end

  def test_boxed_variants_render_pixel_frame
    %i[primary secondary destructive outline].each do |variant|
      output = phlex { PixelRuby.Button(variant:) { "Button" } }

      assert_match(/font-pixel/, output)
      assert_match(/border-4/, output)
      assert_match(/pixel-corners/, output)
      assert_match(/active:pixel-bevel-pressed/, output)
      refute_match(/rounded/, output)
    end
  end

  def test_ghost_and_link_render_without_frame
    %i[ghost link].each do |variant|
      output = phlex { PixelRuby.Button(variant:) { "Button" } }

      assert_match(/font-pixel/, output)
      refute_match(/border-4/, output)
      refute_match(/pixel-bevel/, output)
    end
  end
end
