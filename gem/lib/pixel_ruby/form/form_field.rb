# frozen_string_literal: true

module PixelRuby
  class FormField < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          controller: "pixel-ruby--form-field"
        },
        class: "flex flex-col gap-2"
      }
    end
  end
end
