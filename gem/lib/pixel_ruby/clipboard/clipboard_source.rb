# frozen_string_literal: true

module PixelRuby
  class ClipboardSource < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          pixel_ruby__clipboard_target: "source"
        }
      }
    end
  end
end
