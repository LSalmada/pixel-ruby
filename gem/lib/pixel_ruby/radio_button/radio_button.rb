# frozen_string_literal: true

module PixelRuby
  class RadioButton < Base
    def view_template
      input(**attrs)
    end

    private

    def default_attrs
      {
        type: "radio",
        data: {
          pixel_ruby__form_field_target: "input",
          action: "change->pixel-ruby--form-field#onInput invalid->pixel-ruby--form-field#onInvalid"
        },
        class: [
          "h-4 w-4 p-0 border-primary rounded-full flex-none",
          "disabled:cursor-not-allowed disabled:opacity-50",
          "checked:bg-primary checked:text-primary-foreground dark:checked:bg-secondary checked:text-primary checked:border-primary",
          "aria-disabled:cursor-not-allowed aria-disabled:opacity-50 aria-disabled:pointer-events-none"
        ]
      }
    end
  end
end
