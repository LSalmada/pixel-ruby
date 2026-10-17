# frozen_string_literal: true

module PixelRuby
  class Combobox < Base
    def initialize(term: nil, placement: "bottom-start", **)
      @term = term
      @placement = placement
      super(**)
    end

    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        role: "combobox",
        data: {
          controller: "pixel-ruby--combobox",
          pixel_ruby__combobox_term_value: @term,
          pixel_ruby__combobox_placement_value: @placement,
          action: "turbo:morph@window->pixel-ruby--combobox#updateTriggerContent"
        }
      }
    end
  end
end
