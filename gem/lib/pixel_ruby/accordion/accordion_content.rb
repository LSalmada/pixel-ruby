# frozen_string_literal: true

module PixelRuby
  class AccordionContent < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          pixel_ruby__accordion_target: "content",
          state: "closed"
        },
        class: "overflow-y-hidden",
        style: "height: 0px;",
        hidden: true
      }
    end
  end
end
