# frozen_string_literal: true

module PixelRuby
  class DataTableBulkActions < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        class: "hidden items-center gap-2",
        data: {"pixel-ruby--data-table-target": "bulkActions"}
      }
    end
  end
end
