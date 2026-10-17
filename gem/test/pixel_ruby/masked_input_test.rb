# frozen_string_literal: true

require "test_helper"

class PixelRuby::MaskedInputTest < ComponentTest
  def test_render
    output = phlex do
      PixelRuby.MaskedInput(data: {maska: "#####-###"})
    end

    assert_match(/<input type="text"/, output)
    assert_match(/data-controller="pixel-ruby--masked-input"/, output)
    assert_match(/data-maska="#####-###"/, output)
    refute_match(/<input type="hidden"/, output)
  end

  def test_render_ignores_save_unmasked_and_renders_single_input
    output = phlex do
      PixelRuby.MaskedInput(save_unmasked: true, name: "agency", value: "0000", data: {maska: "####"})
    end

    assert_match(/<input type="text"/, output)
    refute_match(/<input type="hidden"/, output)
    assert_match(/data-maska="####"/, output)
    assert_match(/data-controller="pixel-ruby--masked-input"/, output)
  end
end
