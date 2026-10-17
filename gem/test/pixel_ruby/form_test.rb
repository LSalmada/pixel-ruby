# frozen_string_literal: true

require "test_helper"

class PixelRuby::FormTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Form do
        PixelRuby.FormField do
          PixelRuby.FormFieldLabel { "Label" }
          PixelRuby.Input(placeholder: "Joel Drapper", required: true, minlength: "3") { "Joel Drapper" }
          PixelRuby.FormFieldHint()
          PixelRuby.FormFieldError()
        end
      end
    end

    assert_match(/Joel/, output)
  end
end
