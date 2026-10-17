# frozen_string_literal: true

module PixelRuby
  class SidebarMenuSubItem < Base
    def view_template(&)
      li(**attrs, &)
    end
  end
end
