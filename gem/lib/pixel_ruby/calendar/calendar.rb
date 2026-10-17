# frozen_string_literal: true

module PixelRuby
  class Calendar < Base
    def initialize(selected_date: nil, min_date: nil, input_id: nil, date_format: "yyyy-MM-dd", **attrs)
      @selected_date = selected_date
      @min_date = min_date
      @input_id = input_id
      @date_format = date_format
      super(**attrs)
    end

    def view_template
      div(**attrs) do
        PixelRuby.CalendarHeader do
          PixelRuby.CalendarTitle
          PixelRuby.CalendarPrev
          PixelRuby.CalendarNext
        end
        PixelRuby.CalendarBody # Where the calendar is rendered (Weekdays and Days)
        PixelRuby.CalendarWeekdays # Template for the weekdays
        PixelRuby.CalendarDays # Template for the days
      end
    end

    private

    def default_attrs
      {
        class: "p-3 space-y-4",
        data: {
          controller: "pixel-ruby--calendar",
          pixel_ruby__calendar_selected_date_value: @selected_date&.to_s,
          pixel_ruby__calendar_min_date_value: @min_date&.to_s,
          pixel_ruby__calendar_format_value: @date_format,
          pixel_ruby__calendar_pixel_ruby__calendar_input_outlet: @input_id
        }
      }
    end
  end
end
