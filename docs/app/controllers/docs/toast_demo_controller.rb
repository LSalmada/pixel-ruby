# frozen_string_literal: true

module Docs
  class ToastDemoController < ApplicationController
    def default = push(:default, "Event scheduled", "Friday at 3:00 PM")

    def success = push(:success, "Saved successfully", "Your changes are live.")

    def error = push(:error, "Something went wrong", "Please retry.")

    def warning = push(:warning, "Heads up", "Storage almost full.")

    def info = push(:info, "FYI", "New version available.")

    def with_action
      render turbo_stream: build_stream(:default, "Email archived", nil, action_label: "Undo")
    end

    private

    def push(variant, title, description)
      render turbo_stream: build_stream(variant, title, description)
    end

    def build_stream(variant, title, description, action_label: nil)
      content = ToastFragment.new(
        variant: variant,
        title: title,
        description: description,
        action_label: action_label
      ).call
      turbo_stream.append("pixel-ruby-toaster", content.html_safe)
    end

    class ToastFragment < Phlex::HTML
      def initialize(variant:, title:, description:, action_label: nil)
        @variant = variant
        @title = title
        @description = description
        @action_label = action_label
      end

      def view_template
        render PixelRuby::ToastItem.new(variant: @variant) do
          render PixelRuby::ToastIcon.new(variant: @variant)
          div(class: "flex flex-col gap-1 flex-1 min-w-0") do
            render PixelRuby::ToastTitle.new { @title }
            render(PixelRuby::ToastDescription.new { @description }) if @description
          end
          if @action_label
            render PixelRuby::ToastAction.new(label: @action_label, on: "click->pixel-ruby--toast#dismiss")
          end
          render PixelRuby::ToastClose.new
        end
      end
    end
  end
end
