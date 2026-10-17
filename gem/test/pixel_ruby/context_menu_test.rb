# frozen_string_literal: true

require "test_helper"

class PixelRuby::ContextMenuTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.ContextMenu do
        PixelRuby.ContextMenuTrigger(class: "flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm") { "Right click here" }
        PixelRuby.ContextMenuContent(class: "w-64") do
          PixelRuby.ContextMenuItem(href: "#", shortcut: "⌘[") { "Back" }
          PixelRuby.ContextMenuItem(href: "#", shortcut: "⌘]", disabled: true) { "Forward" }
          PixelRuby.ContextMenuItem(href: "#", shortcut: "⌘R") { "Reload" }
          PixelRuby.ContextMenuSeparator
          PixelRuby.ContextMenuItem(href: "#", shortcut: "⌘⇧B", checked: true) { "Show Bookmarks Bar" }
          PixelRuby.ContextMenuItem(href: "#") { "Show Full URLs" }
          PixelRuby.ContextMenuSeparator
          PixelRuby.ContextMenuLabel(inset: true) { "More Tools" }
          PixelRuby.ContextMenuSeparator
          PixelRuby.ContextMenuItem(href: "#") { "Developer Tools" }
          PixelRuby.ContextMenuItem(href: "#") { "Task Manager" }
          PixelRuby.ContextMenuItem(href: "#") { "Extensions" }
        end
      end
    end

    assert_match(/Right click here/, output)
  end

  # Floating UI positions a real element in the DOM (tippy used to clone a
  # <template>). Content must render as a hidden, absolutely-positioned div.
  def test_content_renders_hidden_positioned_div_not_template
    output = phlex do
      PixelRuby.ContextMenuContent do
        PixelRuby.ContextMenuItem(href: "#") { "Back" }
      end
    end

    refute_match(/<template/, output)
    assert_match(/hidden/, output)
    assert_match(/absolute/, output)
    assert_match(/Back/, output)
  end

  # `hidden` lands a frame after the animation ends; without a forwards fill mode that frame flashes.
  def test_content_holds_the_last_frame_of_the_exit_animation
    output = phlex do
      PixelRuby.ContextMenuContent do
        PixelRuby.ContextMenuItem(href: "#") { "Back" }
      end
    end

    assert_match(/data-\[state=closed\]:fill-mode-forwards/, output)
  end
end
