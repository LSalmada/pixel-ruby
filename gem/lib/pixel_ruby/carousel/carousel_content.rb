# frozen_string_literal: true

module PixelRuby
  class CarouselContent < Base
    def view_template(&)
      div(class: "overflow-hidden", data: {pixel_ruby__carousel_target: "viewport"}) do
        div(**attrs, &)
      end
    end

    private

    def default_attrs
      {
        class: [
          "flex",
          "group-[.is-horizontal]:-ml-4",
          "group-[.is-vertical]:-mt-4 group-[.is-vertical]:flex-col"
        ]
      }
    end
  end
end
