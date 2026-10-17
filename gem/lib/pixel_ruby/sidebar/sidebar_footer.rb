# frozen_string_literal: true

module PixelRuby
  class SidebarFooter < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        class: "flex flex-col gap-2 p-2",
        data: {
          sidebar: "footer"
        }
      }
    end
  end
end
