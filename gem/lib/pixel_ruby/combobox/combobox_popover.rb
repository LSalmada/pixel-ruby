# frozen_string_literal: true

module PixelRuby
  class ComboboxPopover < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        class: "inset-auto m-0 absolute border bg-background shadow-lg rounded-lg",
        role: "popover",
        autofocus: true,
        popover: true,
        data: {
          pixel_ruby__combobox_target: "popover",
          action: %w[
            toggle->pixel-ruby--combobox#handlePopoverToggle
            keydown.down->pixel-ruby--combobox#keyDownPressed
            keydown.up->pixel-ruby--combobox#keyUpPressed
            keydown.enter->pixel-ruby--combobox#keyEnterPressed
            keydown.esc->pixel-ruby--combobox#closePopover:prevent
            resize@window->pixel-ruby--combobox#updatePopoverWidth
          ]
        }
      }
    end
  end
end
