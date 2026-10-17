# frozen_string_literal: true

module PixelRuby
  class ClipboardTrigger < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          pixel_ruby__clipboard_target: "trigger",
          action: "click->pixel-ruby--clipboard#copy"
        }
      }
    end
  end
end
