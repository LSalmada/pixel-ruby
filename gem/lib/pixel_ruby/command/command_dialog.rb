# frozen_string_literal: true

module PixelRuby
  class CommandDialog < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          controller: "pixel-ruby--command-dialog",
          pixel_ruby__command_dialog_pixel_ruby__command_outlet: "[data-pixel-ruby--command-dialog-instance]"
        }
      }
    end
  end
end
