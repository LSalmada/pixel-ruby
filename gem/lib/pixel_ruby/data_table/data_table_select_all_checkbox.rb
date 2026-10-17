# frozen_string_literal: true

module PixelRuby
  class DataTableSelectAllCheckbox < Base
    def view_template
      render PixelRuby::Checkbox.new(**attrs)
    end

    private

    def default_attrs
      {
        aria_label: "Select all",
        data: {
          "pixel-ruby--data-table-target": "selectAll",
          action: "change->pixel-ruby--data-table#toggleAll"
        }
      }
    end
  end
end
