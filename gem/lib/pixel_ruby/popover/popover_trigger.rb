# frozen_string_literal: true

module PixelRuby
  class PopoverTrigger < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          pixel_ruby__popover_target: "trigger"
        },
        class: "inline-block"
      }
    end
  end
end
