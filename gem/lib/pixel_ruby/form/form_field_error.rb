# frozen_string_literal: true

module PixelRuby
  class FormFieldError < Base
    def view_template(&)
      p(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          pixel_ruby__form_field_target: "error"
        },
        class: "empty:hidden text-sm font-medium text-destructive"
      }
    end
  end
end
