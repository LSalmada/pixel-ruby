# frozen_string_literal: true

require "test_helper"

class PixelRuby::BreadcrumbTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Breadcrumb do
        PixelRuby.BreadcrumbList do
          PixelRuby.BreadcrumbItem do
            PixelRuby.BreadcrumbLink(href: "#") { "Home" }
          end
          PixelRuby.BreadcrumbSeparator()
          PixelRuby.BreadcrumbItem do
            PixelRuby.BreadcrumbLink(href: "/docs/accordion") { "Components" }
          end
          PixelRuby.BreadcrumbSeparator()
          PixelRuby.BreadcrumbItem do
            PixelRuby.BreadcrumbPage { "Breadcrumb" }
          end
        end
      end
    end

    assert_match(/Components/, output)
  end
end
