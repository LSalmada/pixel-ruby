# frozen_string_literal: true

module PixelRuby
  class ContextMenuTrigger < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          pixel_ruby__context_menu_target: "trigger",
          action: "contextmenu->pixel-ruby--context-menu#handleContextMenu"
        }
      }
    end
  end
end
