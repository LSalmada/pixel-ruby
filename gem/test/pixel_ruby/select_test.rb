# frozen_string_literal: true

require "test_helper"

class PixelRuby::SelectTest < ComponentTest
  def test_render_with_all_items
    people = [
      ["John Doe", 1],
      ["Jane Doe", 2],
      ["Sam Smith", 3]
    ]

    output = phlex do
      PixelRuby.Select do
        PixelRuby.SelectInput(name: "NAME")
        PixelRuby.SelectTrigger do
          PixelRuby.SelectValue(placeholder: "Placeholder")
        end
        PixelRuby.SelectContent(outlet_id: "1") do
          PixelRuby.SelectGroup do
            people.each do |person|
              PixelRuby.SelectItem(value: person[1]) { person[0] }
            end
          end
        end
      end
    end

    assert_match(/John/, output)
    assert_match('name="NAME"', output)
  end

  def test_select_value_renders_placeholder_when_block_returns_nil
    output = phlex do
      PixelRuby.SelectValue(placeholder: "Placeholder") do
        nil
      end
    end

    assert_match(/Placeholder/, output)
  end

  # `hidden` lands a frame after the animation ends; without a forwards fill mode that frame flashes.
  def test_content_holds_the_last_frame_of_the_exit_animation
    output = phlex do
      PixelRuby.SelectContent { "options" }
    end

    assert_match(/data-\[state=closed\]:fill-mode-forwards/, output)
  end
end
