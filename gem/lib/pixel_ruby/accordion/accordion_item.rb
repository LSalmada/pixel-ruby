# frozen_string_literal: true

module PixelRuby
  class AccordionItem < Base
    def initialize(open: false, rotate_icon: 180, **attrs)
      @open = open
      @rotate_icon = rotate_icon
      super(**attrs)
    end

    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          controller: "pixel-ruby--accordion",
          pixel_ruby__accordion_open_value: @open,
          pixel_ruby__accordion_rotate_icon_value: @rotate_icon
        },
        class: "border-b"
      }
    end
  end
end
