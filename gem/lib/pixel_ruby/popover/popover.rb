# frozen_string_literal: true

module PixelRuby
  class Popover < Base
    def initialize(options: {}, **attrs)
      @options = options
      super(**attrs)
    end

    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          controller: "pixel-ruby--popover",
          pixel_ruby__popover_options_value: @options.to_json,
          pixel_ruby__popover_trigger_value: @options[:trigger] || "hover"
        }
      }
    end
  end
end
