# frozen_string_literal: true

module PixelRuby
  class Collapsible < Base
    def initialize(open: false, **attrs)
      @open = open
      super(**attrs)
    end

    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          controller: "pixel-ruby--collapsible",
          pixel_ruby__collapsible_open_value: @open
        }
      }
    end
  end
end
