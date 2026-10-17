# frozen_string_literal: true

require "test_helper"

class PixelRuby::AvatarTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Avatar do
        PixelRuby.AvatarImage(src: "https://avatars.githubusercontent.com/u/246692?v=4", alt: "joeldrapper")
        PixelRuby.AvatarFallback { "JD" }
      end
    end

    assert_match(/joeldrapper/, output)
    assert_match(/data-controller="pixel-ruby--avatar"/, output)
    assert_match(/data-pixel-ruby--avatar-target="image"/, output)
    assert_match(/load->pixel-ruby--avatar#showImage error->pixel-ruby--avatar#showFallback/, output)
    assert_match(/data-pixel-ruby--avatar-target="fallback"/, output)
    assert_match(/class="aspect-square h-full w-full"/, output)
    refute_match(/class="[^"]*\bhidden\b[^"]*aspect-square/, output)
  end

  def test_image_is_not_lazy_loaded
    # Regression for #415: the controller hides a still-loading image with
    # display:none, and a loading="lazy" image with no box is never fetched, so
    # it would stay hidden forever. The avatar image must load eagerly.
    output = phlex do
      PixelRuby.Avatar do
        PixelRuby.AvatarImage(src: "https://avatars.githubusercontent.com/u/246692?v=4", alt: "joeldrapper")
        PixelRuby.AvatarFallback { "JD" }
      end
    end

    refute_match(/loading="lazy"/, output)
  end
end
