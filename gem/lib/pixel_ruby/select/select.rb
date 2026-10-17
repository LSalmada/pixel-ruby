# frozen_string_literal: true

module PixelRuby
  class Select < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          controller: "pixel-ruby--select",
          pixel_ruby__select_open_value: "false",
          action: "click@window->pixel-ruby--select#clickOutside",
          pixel_ruby__select_pixel_ruby__select_item_outlet: ".item"
        },
        class: "group/select w-full relative"
      }
    end
  end
end
