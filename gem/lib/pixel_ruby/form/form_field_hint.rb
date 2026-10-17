# frozen_string_literal: true

module PixelRuby
  class FormFieldHint < Base
    def view_template(&)
      p(**attrs, &)
    end

    private

    def default_attrs
      {class: "empty:hidden text-sm text-muted-foreground"}
    end
  end
end
