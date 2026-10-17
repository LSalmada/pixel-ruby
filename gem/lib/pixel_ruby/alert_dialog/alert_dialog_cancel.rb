# frozen_string_literal: true

module PixelRuby
  class AlertDialogCancel < Base
    def view_template(&)
      render PixelRuby::Button.new(**attrs, &)
    end

    private

    def default_attrs
      {
        variant: :outline,
        data: {
          action: "click->pixel-ruby--alert-dialog#dismiss"
        },
        class: "mt-2 sm:mt-0"
      }
    end
  end
end
