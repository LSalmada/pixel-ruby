# frozen_string_literal: true

module PixelRuby
  class InputOtp < Base
    def initialize(length:, pattern: nil, **attrs)
      @length = length
      @char_class = pattern || "[0-9]"
      super(**attrs)
    end

    def view_template(&block)
      div(
        data: {
          controller: "pixel-ruby--input-otp",
          pixel_ruby__input_otp_length_value: @length,
          pixel_ruby__input_otp_char_class_value: @char_class
        },
        class: "relative flex items-center has-disabled:opacity-50"
      ) do
        div(class: "flex items-center gap-2", &block)
        input(**attrs)
      end
    end

    private

    def default_attrs
      {
        type: "text",
        inputmode: (@char_class == "[0-9]") ? "numeric" : "text",
        pattern: "^(?:#{@char_class}){#{@length}}$",
        maxlength: @length,
        autocomplete: "one-time-code",
        data: {
          pixel_ruby__input_otp_target: "input",
          action: "input->pixel-ruby--input-otp#onInput keydown->pixel-ruby--input-otp#onKeydown paste->pixel-ruby--input-otp#onPaste focus->pixel-ruby--input-otp#onFocus blur->pixel-ruby--input-otp#onBlur"
        },
        class: "absolute inset-0 h-full w-full cursor-text appearance-none border-0 bg-transparent p-0 text-transparent caret-transparent shadow-none outline-none selection:bg-transparent focus:outline-none focus:ring-0 focus-visible:outline-none focus-visible:ring-0 disabled:cursor-not-allowed"
      }
    end
  end
end
