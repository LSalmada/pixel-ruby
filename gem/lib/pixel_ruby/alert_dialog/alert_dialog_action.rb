# frozen_string_literal: true

module PixelRuby
  class AlertDialogAction < Base
    def view_template(&)
      render PixelRuby::Button.new(**attrs, &)
    end

    private

    def default_attrs
      {
        variant: :primary
      }
    end
  end
end
