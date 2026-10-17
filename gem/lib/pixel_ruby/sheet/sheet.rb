# frozen_string_literal: true

module PixelRuby
  class Sheet < Base
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
          controller: "pixel-ruby--sheet",
          pixel_ruby__sheet_open_value: @open.to_s
        }
      }
    end
  end
end
