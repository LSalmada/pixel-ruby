# frozen_string_literal: true

module PixelRuby
  class TooltipTrigger < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          pixel_ruby__tooltip_target: "trigger",
          action: [
            "mouseenter->pixel-ruby--tooltip#show",
            "mouseleave->pixel-ruby--tooltip#hide",
            "focus->pixel-ruby--tooltip#show",
            "blur->pixel-ruby--tooltip#hide"
          ]
        },
        variant: :outline
      }
    end
  end
end
