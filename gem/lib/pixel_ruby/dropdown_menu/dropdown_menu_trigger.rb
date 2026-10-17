# frozen_string_literal: true

module PixelRuby
  class DropdownMenuTrigger < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {pixel_ruby__dropdown_menu_target: "trigger", action: "click->pixel-ruby--dropdown-menu#toggle"},
        class: "inline-block"
      }
    end
  end
end
