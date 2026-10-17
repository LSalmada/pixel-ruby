# frozen_string_literal: true

require "test_helper"

class PixelRuby::SheetTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Sheet do
        PixelRuby.SheetTrigger do
          PixelRuby.Button(variant: :outline) { "Open Sheet" }
        end

        PixelRuby.SheetContent(class: "sm:max-w-sm") do
          PixelRuby.SheetHeader do
            PixelRuby.SheetTitle { "Edit profile" }
            PixelRuby.SheetDescription { "Make changes to your profile here. Click save when you're done." }
          end
          PixelRuby.SheetMiddle do
            PixelRuby.Input(placeholder: "Joel Drapper") { "Joel Drapper" }
            PixelRuby.Input(placeholder: "joel@drapper.me")

            PixelRuby.SheetFooter do
              PixelRuby.Button(variant: :outline, data: {action: "click->pixel-ruby--sheet-content#close"}) { "Cancel" }
              PixelRuby.Button(type: "submit") { "Save" }
            end
          end
        end
      end
    end

    assert_match(/Open Sheet/, output)
  end

  def test_render_closed_by_default
    output = phlex { PixelRuby.Sheet { "content" } }

    assert_match(/data-pixel-ruby--sheet-open-value="false"/, output)
  end

  def test_render_open_when_open_is_true
    output = phlex { PixelRuby.Sheet(open: true) { "content" } }

    assert_match(/data-pixel-ruby--sheet-open-value="true"/, output)
  end

  # Removal lands a frame after the animation ends; without a forwards fill mode that frame flashes.
  def test_content_and_backdrop_hold_the_last_frame_of_the_exit_animation
    output = phlex do
      PixelRuby.SheetContent { "sheet body" }
    end

    assert_equal 2, output.scan("data-[state=closed]:fill-mode-forwards").size
  end
end
