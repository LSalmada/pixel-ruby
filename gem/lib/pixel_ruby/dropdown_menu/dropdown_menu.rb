# frozen_string_literal: true

module PixelRuby
  class DropdownMenu < Base
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
        class: [
          "group/dropdown-menu",
          (strategy == "fixed") ? "is-fixed" : "is-absolute"
        ],
        data: {
          controller: "pixel-ruby--dropdown-menu",
          action: "click@window->pixel-ruby--dropdown-menu#onClickOutside",
          pixel_ruby__dropdown_menu_options_value: @options.to_json
        }
      }
    end

    def strategy
      @_strategy ||= @options[:strategy] || "absolute"
    end
  end
end
