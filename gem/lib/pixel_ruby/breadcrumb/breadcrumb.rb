# frozen_string_literal: true

module PixelRuby
  class Breadcrumb < Base
    def view_template(&)
      nav(**attrs, &)
    end

    private

    def default_attrs
      {
        aria: {label: "breadcrumb"}
      }
    end
  end
end
