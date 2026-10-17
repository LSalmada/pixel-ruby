# frozen_string_literal: true

require "test_helper"

class PixelRuby::CardTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Card(class: "w-96") do
        PixelRuby.CardHeader do
          PixelRuby.CardTitle { 'You might like "PixelRuby"' }
          PixelRuby.CardDescription { "@joeldrapper" }
        end
        PixelRuby.CardContent do
          PixelRuby.AspectRatio(aspect_ratio: "16/9", class: "rounded-md overflow-hidden border") do |aspect_ratio|
            aspect_ratio.img(
              alt: "Placeholder",
              loading: "lazy",
              src: "https://avatars.githubusercontent.com/u/246692?v=4"
            )
          end
        end
        PixelRuby.CardFooter(class: "flex justify-end gap-x-2") do
          PixelRuby.Button(variant: :outline) { "See more" }
          PixelRuby.Button(variant: :primary) { "Buy now" }
        end
      end
    end

    assert_match(/You might like/, output)
  end
end
