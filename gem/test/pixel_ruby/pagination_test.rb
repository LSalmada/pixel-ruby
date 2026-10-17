# frozen_string_literal: true

require "test_helper"

class PixelRuby::PaginationTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Pagination do
        PixelRuby.PaginationContent do
          PixelRuby.PaginationItem(href: "#") do |item|
            item.plain "First"
          end
          PixelRuby.PaginationItem(href: "#") do |item|
            item.plain "Prev"
          end

          PixelRuby.PaginationEllipsis

          PixelRuby.PaginationItem(href: "#") { "4" }
          PixelRuby.PaginationItem(href: "#", active: true) { "5" }
          PixelRuby.PaginationItem(href: "#") { "6" }

          PixelRuby.PaginationEllipsis

          PixelRuby.PaginationItem(href: "#") do |item|
            item.plain "Next"
          end
          PixelRuby.PaginationItem(href: "#") do |item|
            item.plain "Last"
          end
        end
      end
    end

    assert_match(/First/, output)
  end
end
