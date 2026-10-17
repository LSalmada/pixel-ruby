# frozen_string_literal: true

module PixelRuby
  class Carousel < Base
    def initialize(orientation: :horizontal, options: {}, **user_attrs)
      @orientation = orientation
      @options = options

      super(**user_attrs)
    end

    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        class: ["relative group", orientation_classes],
        role: "region",
        aria_roledescription: "carousel",
        data: {
          controller: "pixel-ruby--carousel",
          pixel_ruby__carousel_options_value: default_options.merge(@options).to_json,
          action: %w[
            keydown.right->pixel-ruby--carousel#scrollNext:prevent
            keydown.left->pixel-ruby--carousel#scrollPrev:prevent
          ]
        }
      }
    end

    def default_options
      {
        axis: (@orientation == :horizontal) ? "x" : "y"
      }
    end

    def orientation_classes
      (@orientation == :horizontal) ? "is-horizontal" : "is-vertical"
    end
  end
end
