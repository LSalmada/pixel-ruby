# frozen_string_literal: true

module PixelRuby
  class ToastRegion < Base
    SKELETON_VARIANTS = %i[default success error warning info loading].freeze

    def initialize(
      position: :bottom_right,
      expand: false,
      max: 3,
      duration: 4000,
      gap: 14,
      offset: 24,
      theme: :system,
      rich_colors: false,
      close_button: false,
      hotkey: %w[alt t],
      dir: :ltr,
      flash: nil,
      **attrs
    )
      @position = position.to_sym
      @expand = expand
      @max = max
      @duration = duration
      @gap = gap
      @offset = offset
      @theme = theme.to_sym
      @rich_colors = rich_colors
      @close_button = close_button
      @hotkey = hotkey
      @dir = dir
      @flash = flash
      super(**attrs)
    end

    def view_template(&block)
      div(**attrs) do
        ol(id: "pixel-ruby-toaster", class: "pointer-events-auto relative m-0 p-0 list-none w-[356px] max-w-full") do
          render_flash if @flash
          yield(self) if block
        end
        SKELETON_VARIANTS.each { |v| skeleton(v) }
        slot_template("actionTpl") { render PixelRuby::ToastAction.new(label: "") }
        slot_template("cancelTpl") { render PixelRuby::ToastCancel.new(label: "") }
        slot_template("closeTpl") { render PixelRuby::ToastClose.new }
      end
    end

    private

    def render_flash
      @flash.each do |key, message|
        next if message.nil? || message.to_s.empty?
        variant = PixelRuby::Toast.flash_variant(key)
        render PixelRuby::ToastItem.new(variant: variant, id: "flash-#{key}") do
          render PixelRuby::ToastIcon.new(variant: variant)
          render PixelRuby::ToastTitle.new { message.to_s }
        end
      end
    end

    def skeleton(variant)
      template(
        data: {
          pixel_ruby__toaster_target: "skeleton",
          variant: variant.to_s
        }
      ) do
        render PixelRuby::ToastItem.new(variant: variant) do
          render PixelRuby::ToastIcon.new(variant: variant)
          div(class: "flex flex-col gap-0.5 flex-1 min-w-0") do
            render PixelRuby::ToastTitle.new
            render PixelRuby::ToastDescription.new
          end
          render PixelRuby::ToastClose.new if @close_button
        end
      end
    end

    def slot_template(target_name, &)
      template(data: {pixel_ruby__toaster_target: target_name}, &)
    end

    def default_attrs
      {
        id: "pixel-ruby-toaster-region",
        role: "region",
        aria_label: "Notifications",
        aria_live: "polite",
        data: {
          controller: "pixel-ruby--toaster",
          turbo_permanent: "",
          close_button: @close_button.to_s,
          position: @position.to_s.tr("_", "-"),
          pixel_ruby__toaster_position_value: @position.to_s.tr("_", "-"),
          pixel_ruby__toaster_expand_value: @expand.to_s,
          pixel_ruby__toaster_max_value: @max.to_s,
          pixel_ruby__toaster_duration_value: @duration.to_s,
          pixel_ruby__toaster_gap_value: @gap.to_s,
          pixel_ruby__toaster_offset_value: @offset.to_s,
          pixel_ruby__toaster_theme_value: @theme.to_s,
          pixel_ruby__toaster_rich_colors_value: @rich_colors.to_s,
          pixel_ruby__toaster_close_button_value: @close_button.to_s,
          pixel_ruby__toaster_hotkey_value: Array(@hotkey).join("+"),
          pixel_ruby__toaster_dir_value: @dir.to_s
        },
        class: region_classes
      }
    end

    def region_classes
      <<~CLASSES.tr("\n", " ").squeeze(" ").strip
        group/toaster pointer-events-none fixed z-[100] p-4 sm:p-6
        data-[position=top-left]:top-0 data-[position=top-left]:left-0
        data-[position=top-center]:top-0 data-[position=top-center]:left-1/2 data-[position=top-center]:-translate-x-1/2
        data-[position=top-right]:top-0 data-[position=top-right]:right-0
        data-[position=bottom-left]:bottom-0 data-[position=bottom-left]:left-0
        data-[position=bottom-center]:bottom-0 data-[position=bottom-center]:left-1/2 data-[position=bottom-center]:-translate-x-1/2
        data-[position=bottom-right]:bottom-0 data-[position=bottom-right]:right-0
      CLASSES
    end
  end
end
