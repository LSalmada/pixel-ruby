# frozen_string_literal: true

module PixelRuby
  class BubbleGroup < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {slot: "bubble-group"},
        class: "flex min-w-0 flex-col gap-2"
      }
    end
  end
end
