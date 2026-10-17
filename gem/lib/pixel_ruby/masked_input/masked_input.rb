# frozen_string_literal: true

module PixelRuby
  class MaskedInput < Base
    def view_template
      Input(type: "text", **attrs)
    end

    private

    def default_attrs
      {data: {controller: "pixel-ruby--masked-input"}}
    end
  end
end
