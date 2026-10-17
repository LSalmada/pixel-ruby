# frozen_string_literal: true

module PixelRuby
  class ThemeToggle < Base
    def view_template(&block)
      PixelRuby.Toggle(
        variant: :default,
        size: :default,
        aria: {label: "Toggle theme"},
        wrapper: {
          data: {
            controller: "pixel-ruby--theme-toggle",
            action: "pixel-ruby--toggle:change->pixel-ruby--theme-toggle#apply"
          }
        },
        **attrs,
        &block
      )
    end
  end
end
