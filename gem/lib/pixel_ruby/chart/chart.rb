# frozen_string_literal: true

module PixelRuby
  class Chart < Base
    def initialize(options: {}, **attrs)
      @options = options.to_json
      super(**attrs)
    end

    def view_template(&)
      canvas(**attrs, &)
    end

    private

    def default_attrs
      {
        data_controller: "pixel-ruby--chart",
        data_pixel_ruby__chart_options_value: @options
      }
    end
  end
end
