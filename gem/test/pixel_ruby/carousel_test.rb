# frozen_string_literal: true

require "test_helper"

class PixelRuby::CarouselTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Carousel do
        PixelRuby.CarouselContent do
          PixelRuby.CarouselItem { "Item" }
        end
        PixelRuby.CarouselPrevious()
        PixelRuby.CarouselNext()
      end
    end

    assert_match(/Item/, output)
    assert_match(/button/, output)
    assert_match(/ is-horizontal/, output)
  end

  def test_render_with_horizontal_orientation
    output = phlex do
      PixelRuby.Carousel(orientation: :horizontal) do
        PixelRuby.CarouselContent() do
          PixelRuby.CarouselItem() { "Item" }
        end
        PixelRuby.CarouselPrevious()
        PixelRuby.CarouselNext()
      end
    end

    assert_match(/ is-horizontal/, output)
  end

  def test_render_with_vertical_orientation
    output = phlex do
      PixelRuby.Carousel(orientation: :vertical) do
        PixelRuby.CarouselContent() do
          PixelRuby.CarouselItem() { "Item" }
        end
        PixelRuby.CarouselPrevious()
        PixelRuby.CarouselNext()
      end
    end

    assert_match(/ is-vertical/, output)
  end
end
