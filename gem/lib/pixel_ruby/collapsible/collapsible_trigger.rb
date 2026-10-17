# frozen_string_literal: true

module PixelRuby
  class CollapsibleTrigger < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          action: "click->pixel-ruby--collapsible#toggle"
        }
      }
    end
  end
end
