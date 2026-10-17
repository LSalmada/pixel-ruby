# frozen_string_literal: true

module PixelRuby
  class SheetTrigger < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {action: "click->pixel-ruby--sheet#open"}
      }
    end
  end
end
