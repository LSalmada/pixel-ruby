# frozen_string_literal: true

module PixelRuby
  class CommandEmpty < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        class: "py-6 text-center text-sm",
        role: "presentation",
        data: {pixel_ruby__command_target: "empty"}
      }
    end
  end
end
