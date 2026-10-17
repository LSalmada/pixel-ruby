# frozen_string_literal: true

module PixelRuby
  class Command < Base
    def view_template(&)
      div(**attrs, &)
    end
  end
end
