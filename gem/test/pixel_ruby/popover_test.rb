# frozen_string_literal: true

require "test_helper"

class PixelRuby::PopoverTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Popover do
        PixelRuby.PopoverTrigger(class: "w-full") do
          PixelRuby.Button(variant: :outline) { "Open Popover" }
        end
        PixelRuby.PopoverContent(class: "w-40") do
          PixelRuby.Link(href: "#", variant: :ghost, class: "block w-full justify-start pl-2") do |link|
            link.plain "Profile"
          end
          PixelRuby.Link(href: "#", variant: :ghost, class: "block w-full justify-start pl-2") do |link|
            link.plain "Settings"
          end
          PixelRuby.Link(href: "#", variant: :ghost, class: "block w-full justify-start pl-2") do |link|
            link.plain "Logout"
          end
        end
      end
    end

    assert_match(/Profile/, output)
  end

  # The animation classes on the content are keyed on data-state, so the
  # attribute has to be present before the Stimulus controller ever runs.
  def test_content_renders_closed_state_by_default
    output = phlex do
      PixelRuby.PopoverContent { "popover body" }
    end

    assert_match(/data-state="closed"/, output)
    assert_match(/hidden/, output)
    assert_match(/absolute/, output)
    assert_match(/popover body/, output)
  end

  # `hidden` lands a frame after the animation ends; without a forwards fill mode that frame flashes.
  def test_content_holds_the_last_frame_of_the_exit_animation
    output = phlex do
      PixelRuby.PopoverContent { "popover body" }
    end

    assert_match(/data-\[state=closed\]:fill-mode-forwards/, output)
  end
end
