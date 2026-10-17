# frozen_string_literal: true

module PixelRuby
  class CollapsibleContent < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {pixel_ruby__collapsible_target: "content"},
        class: "overflow-y-hidden"
      }
    end
  end
end
