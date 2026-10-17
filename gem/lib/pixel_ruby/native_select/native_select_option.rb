# frozen_string_literal: true

module PixelRuby
  class NativeSelectOption < Base
    def view_template(&)
      option(**attrs, &)
    end

    private

    def default_attrs
      {}
    end
  end
end
