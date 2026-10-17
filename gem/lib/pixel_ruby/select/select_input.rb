# frozen_string_literal: true

module PixelRuby
  class SelectInput < Base
    def view_template
      input(**attrs)
    end

    private

    def default_attrs
      {
        class: "hidden",
        data: {
          pixel_ruby__select_target: "input",
          pixel_ruby__form_field_target: "input",
          action: "change->pixel-ruby--form-field#onChange invalid->pixel-ruby--form-field#onInvalid"
        }
      }
    end
  end
end
