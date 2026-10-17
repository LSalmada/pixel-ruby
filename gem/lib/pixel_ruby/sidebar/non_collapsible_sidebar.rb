# frozen_string_literal: true

module PixelRuby
  class NonCollapsibleSidebar < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        class: "flex h-full w-[var(--sidebar-width)] flex-col bg-sidebar text-sidebar-foreground"
      }
    end
  end
end
