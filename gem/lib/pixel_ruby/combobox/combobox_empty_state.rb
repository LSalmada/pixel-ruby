# frozen_string_literal: true

module PixelRuby
  class ComboboxEmptyState < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        role: "presentation",
        class: "hidden py-6 text-center text-sm",
        data: {
          pixel_ruby__combobox_target: "emptyState"
        }
      }
    end
  end
end
