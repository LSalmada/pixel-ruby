# frozen_string_literal: true

module PixelRuby
  class ToastTitle < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {slot: "title"},
        class: "font-medium leading-normal"
      }
    end
  end
end
