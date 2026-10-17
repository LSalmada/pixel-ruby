# frozen_string_literal: true

require "test_helper"

class PixelRuby::CollapsibleTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Collapsible(open: true) do
        PixelRuby.CollapsibleTrigger do
          PixelRuby.Button(variant: :ghost, icon: true) do |button|
            button.span(class: "sr-only") { "Toggle" }
          end
        end

        PixelRuby.CollapsibleContent do |content|
          content.div(class: "rounded-md border px-4 py-2 font-mono text-sm shadow-sm") do
            "phlex-ruby/phlex-rails"
          end
          content.div(class: "rounded-md border px-4 py-2 font-mono text-sm shadow-sm") do
            "pixel_ruby/pixel_ruby"
          end
        end
      end
    end

    assert_match(/Toggle/, output)
  end
end
