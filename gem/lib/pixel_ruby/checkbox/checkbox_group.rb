# frozen_string_literal: true

module PixelRuby
  class CheckboxGroup < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        role: "group",
        data: {
          controller: "pixel-ruby--checkbox-group"
        }
      }
    end
  end
end
