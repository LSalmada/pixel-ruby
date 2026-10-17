# frozen_string_literal: true

module PixelRuby
  class CalendarBody < Base
    def view_template
      table(**attrs)
    end

    private

    def default_attrs
      {
        data: {
          pixel_ruby__calendar_target: "calendar"
        }
      }
    end
  end
end
