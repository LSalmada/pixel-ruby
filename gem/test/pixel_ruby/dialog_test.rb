# frozen_string_literal: true

require "test_helper"

class PixelRuby::DialogTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Dialog do
        PixelRuby.DialogTrigger do
          PixelRuby.Button { "Open Dialog" }
        end
        PixelRuby.DialogContent do
          PixelRuby.DialogHeader do
            PixelRuby.DialogTitle { "PixelRuby to the rescue" }
            PixelRuby.DialogDescription { "PixelRuby helps you build accessible standard compliant web apps with ease" }
          end
          PixelRuby.DialogMiddle do
            PixelRuby.AspectRatio(aspect_ratio: "16/9", class: "rounded-md overflow-hidden border") do |aspect|
              aspect.img(
                alt: "Placeholder",
                loading: "lazy",
                src: "https://avatars.githubusercontent.com/u/246692?v=4"
              )
            end
          end
          PixelRuby.DialogFooter do
            PixelRuby.Button(variant: :outline, data: {action: "click->pixel-ruby--dialog#dismiss"}) { "Cancel" }
            PixelRuby.Button { "Save" }
          end
        end
      end
    end

    assert_match(/Open Dialog/, output)
  end

  # Regression test for #343: Dialog content must use native <dialog> element, not <div>
  def test_dialog_content_renders_native_dialog_element
    output = phlex do
      PixelRuby.Dialog do
        PixelRuby.DialogContent { "Content" }
      end
    end

    assert_match(/<dialog[\s>]/, output, "DialogContent must render a native <dialog> element")
    refute_match(/<template[\s>]/, output, "DialogContent must not use a <template> element")
  end

  def test_dialog_wrapper_renders_as_div_with_stimulus_controller
    output = phlex do
      PixelRuby.Dialog do
        PixelRuby.DialogContent { "Content" }
      end
    end

    assert_match(/data-controller="pixel-ruby--dialog"/, output)
    assert_match(/<div[^>]*data-controller="pixel-ruby--dialog"/, output, "Dialog wrapper must be a <div>")
  end

  def test_dialog_content_has_stimulus_target
    output = phlex do
      PixelRuby.Dialog do
        PixelRuby.DialogContent { "Content" }
      end
    end

    assert_match(/data-pixel-ruby--dialog-target="dialog"/, output)
  end

  def test_dialog_content_has_backdrop_click_action
    output = phlex do
      PixelRuby.Dialog do
        PixelRuby.DialogContent { "Content" }
      end
    end

    assert_match(/data-action="click->pixel-ruby--dialog#backdropClick"/, output)
  end

  # Regression test: a closed native <dialog> must stay hidden. The bare `flex`
  # utility (author CSS) overrides the UA `dialog:not([open]) { display: none }`,
  # making the dialog always visible. Display must be gated on the open: variant.
  def test_dialog_content_does_not_force_display_when_closed
    output = phlex do
      PixelRuby.Dialog do
        PixelRuby.DialogContent { "Content" }
      end
    end

    classes = output[/<dialog\b.*?\sclass="([^"]*)"/m, 1].to_s.split
    refute_includes classes, "flex", "Bare `flex` forces a closed <dialog> to display; use `open:flex`"
    assert_includes classes, "open:flex", "Dialog must apply flex only when open (open:flex)"
  end

  def test_dialog_content_sizes
    {xs: "max-w-sm", sm: "max-w-md", md: "max-w-lg", lg: "max-w-2xl", xl: "max-w-4xl", full: "max-w-full"}.each do |size, expected_class|
      output = phlex do
        PixelRuby.Dialog do
          PixelRuby.DialogContent(size: size) { "Content" }
        end
      end

      assert_match(/#{Regexp.escape(expected_class)}/, output, "Size #{size} should apply class #{expected_class}")
    end
  end

  def test_dialog_open_value_is_set_on_wrapper
    output = phlex do
      PixelRuby.Dialog(open: true) do
        PixelRuby.DialogContent { "Content" }
      end
    end

    assert_match(/data-pixel-ruby--dialog-open-value/, output)
  end

  def test_close_button_has_dismiss_action
    output = phlex do
      PixelRuby.Dialog do
        PixelRuby.DialogContent { "Content" }
      end
    end

    assert_match(/data-action="click->pixel-ruby--dialog#dismiss"/, output)
  end

  def test_trigger_has_open_action
    output = phlex do
      PixelRuby.Dialog do
        PixelRuby.DialogTrigger do
          PixelRuby.Button { "Open" }
        end
        PixelRuby.DialogContent { "Content" }
      end
    end

    assert_match(/data-action="click->pixel-ruby--dialog#open"/, output)
  end
end
