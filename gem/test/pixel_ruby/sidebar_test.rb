# frozen_string_literal: true

require "test_helper"

class PixelRuby::SidebarTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.SidebarWrapper do
        PixelRuby.Sidebar do
          PixelRuby.SidebarHeader do
            PixelRuby.SidebarGroup do
              PixelRuby.SidebarGroupContent do
                PixelRuby.SidebarInput(id: "search", placeholder: "Search the docs")
              end
            end
          end
          PixelRuby.SidebarContent do
            PixelRuby.SidebarGroup do
              PixelRuby.SidebarGroupLabel { "Application" }
              PixelRuby.SidebarGroupAction { "Group Action" }
              PixelRuby.SidebarGroupContent do
                PixelRuby.SidebarMenu do
                  PixelRuby.SidebarMenuItem do
                    PixelRuby.SidebarMenuSub do
                      PixelRuby.SidebarMenuSubItem do
                        PixelRuby.SidebarMenuSubButton(as: :a, href: "#") { "Sub Item 1" }
                      end
                    end
                  end
                  PixelRuby.SidebarMenuItem do
                    PixelRuby.SidebarMenuButton(as: :a, href: "#") { "Settings" }
                    PixelRuby.SidebarMenuAction { "Settings" }
                  end
                  PixelRuby.SidebarMenuItem do
                    PixelRuby.SidebarMenuButton { "Dashboard" }
                    PixelRuby.SidebarMenuAction { "Dashboard" }
                    PixelRuby.SidebarMenuBadge { "Dashboard Badge" }
                  end
                  PixelRuby.SidebarMenuItem do
                    PixelRuby.SidebarMenuSkeleton()
                  end
                end
              end
            end
            PixelRuby.SidebarSeparator()
          end
          PixelRuby.SidebarFooter { "Footer" }
          PixelRuby.SidebarRail()
        end
        PixelRuby.SidebarInset do
          PixelRuby.SidebarTrigger()
        end
      end
    end

    assert_match(/Search the docs/, output)
    assert_match(/Application/, output)
    assert_match(/Group Action/, output)
    assert_match(/Sub Item 1/, output)
    assert_match(/Settings/, output)
    assert_match(/Dashboard/, output)
    assert_match(/Dashboard Badge/, output)
    assert_match(/Footer/, output)
  end

  def test_render_non_collapsible_sidebar
    output = phlex do
      PixelRuby.SidebarWrapper do
        PixelRuby.Sidebar(collapsible: :none) do
          PixelRuby.SidebarHeader do
            PixelRuby.SidebarGroup do
              PixelRuby.SidebarGroupContent do
                PixelRuby.SidebarInput(id: "search", placeholder: "Search the docs")
              end
            end
          end
          PixelRuby.SidebarContent do
            PixelRuby.SidebarGroup do
              PixelRuby.SidebarGroupLabel { "Application" }
              PixelRuby.SidebarGroupAction { "Group Action" }
              PixelRuby.SidebarGroupContent do
                PixelRuby.SidebarMenu do
                  PixelRuby.SidebarMenuItem do
                    PixelRuby.SidebarMenuSub do
                      PixelRuby.SidebarMenuSubItem do
                        PixelRuby.SidebarMenuSubButton(as: :a, href: "#") { "Sub Item 1" }
                      end
                    end
                  end
                  PixelRuby.SidebarMenuItem do
                    PixelRuby.SidebarMenuButton(as: :a, href: "#") { "Settings" }
                    PixelRuby.SidebarMenuAction { "Settings" }
                  end
                  PixelRuby.SidebarMenuItem do
                    PixelRuby.SidebarMenuButton { "Dashboard" }
                    PixelRuby.SidebarMenuAction { "Dashboard" }
                    PixelRuby.SidebarMenuBadge { "Dashboard Badge" }
                  end
                  PixelRuby.SidebarMenuItem do
                    PixelRuby.SidebarMenuSkeleton()
                  end
                end
              end
            end
            PixelRuby.SidebarSeparator()
          end
          PixelRuby.SidebarFooter { "Footer" }
          PixelRuby.SidebarRail()
        end
        PixelRuby.SidebarInset do
          PixelRuby.SidebarTrigger()
        end
      end
    end

    assert_match(/Search the docs/, output)
    assert_match(/Application/, output)
    assert_match(/Group Action/, output)
    assert_match(/Sub Item 1/, output)
    assert_match(/Settings/, output)
    assert_match(/Dashboard/, output)
    assert_match(/Dashboard Badge/, output)
    assert_match(/Footer/, output)
  end

  def test_with_side_right
    output = phlex do
      PixelRuby.Sidebar(side: :right)
    end

    assert_match(/data-side="right"/, output)
  end

  def test_with_variant_floating
    output = phlex do
      PixelRuby.Sidebar(variant: :floating)
    end

    assert_match(/data-variant="floating"/, output)
  end

  def test_with_collapsible_icon
    output = phlex do
      PixelRuby.Sidebar(collapsible: :icon)
    end

    assert_match(/data-collapsible-kind="icon"/, output)
  end

  def test_with_open_false
    output = phlex do
      PixelRuby.Sidebar(open: false)
    end

    assert_match(/data-state="collapsed"/, output)
  end

  def test_with_collapsible_offcanvas
    output = phlex do
      PixelRuby.Sidebar(collapsible: :offcanvas)
    end

    assert_match(/data-collapsible-kind="offcanvas"/, output)
  end
end
