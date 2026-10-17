# frozen_string_literal: true

module PixelRuby
  class Checkbox < Base
    def view_template
      input(**attrs)
    end

    private

    def default_attrs
      {
        type: "checkbox",
        data: {
          pixel_ruby__form_field_target: "input",
          pixel_ruby__checkbox_group_target: "checkbox",
          action: "change->pixel-ruby--checkbox-group#onChange change->pixel-ruby--form-field#onInput invalid->pixel-ruby--form-field#onInvalid"
        },
        class: [
          "peer h-4 w-4 shrink-0 rounded-sm border-input ring-offset-background accent-primary",
          "disabled:cursor-not-allowed disabled:opacity-50",
          "checked:bg-primary checked:text-primary-foreground dark:checked:bg-secondary checked:text-primary checked:border-primary",
          "aria-disabled:cursor-not-allowed aria-disabled:opacity-50 aria-disabled:pointer-events-none",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
        ]
      }
    end
  end
end
