# frozen_string_literal: true

module PixelRuby
  class Tooltip < Base
    def initialize(placement: "top", **attrs)
      @placement = placement
      super(**attrs)
    end

    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          controller: "pixel-ruby--tooltip",
          pixel_ruby__tooltip_placement_value: @placement
        },
        class: "group"
      }
    end
  end
end
