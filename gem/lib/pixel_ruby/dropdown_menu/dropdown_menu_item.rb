# frozen_string_literal: true

module PixelRuby
  class DropdownMenuItem < Base
    def initialize(as: :a, href: "#", **attrs)
      @as = as
      @href = href
      super(**attrs)
    end

    def view_template(&)
      if @as == :div
        div(**attrs, &)
      else
        a(**attrs, &)
      end
    end

    private

    def default_attrs
      base = {
        role: "menuitem",
        class: "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground aria-selected:bg-accent aria-selected:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
        data_action: "click->pixel-ruby--dropdown-menu#close",
        data_pixel_ruby__dropdown_menu_target: "menuItem",
        tabindex: "-1",
        data_orientation: "vertical"
      }
      base[:href] = @href unless @as == :div
      base
    end
  end
end
