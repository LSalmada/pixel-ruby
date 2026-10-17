# frozen_string_literal: true

module PixelRuby
  class DialogTrigger < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          action: "click->pixel-ruby--dialog#open"
        },
        class: "inline-block"
      }
    end
  end
end
