# frozen_string_literal: true

module PixelRuby
  class Button < Base
    BASE_CLASSES = [
      "whitespace-nowrap inline-flex items-center justify-center font-pixel leading-none cursor-pointer",
      "disabled:pointer-events-none disabled:opacity-50",
      "focus-visible:outline-2 focus-visible:outline-dashed focus-visible:outline-current focus-visible:-outline-offset-8",
      "aria-disabled:pointer-events-none aria-disabled:opacity-50 aria-disabled:cursor-not-allowed"
    ].freeze

    PIXEL_BOX_CLASSES = "border-4 border-foreground pixel-corners pixel-bevel active:pixel-bevel-pressed"

    def initialize(type: :button, variant: :primary, size: :md, icon: false, **attrs)
      @type = type
      @variant = variant.to_sym
      @size = size.to_sym
      @icon = icon
      super(**attrs)
    end

    def view_template(&)
      button(**attrs, &)
    end

    private

    def size_classes
      if @icon
        case @size
        when :sm then "h-6 w-6"
        when :md then "h-9 w-9"
        when :lg then "h-10 w-10"
        when :xl then "h-12 w-12"
        end
      else
        case @size
        when :sm then "px-3 py-1.5 h-8 text-xs"
        when :md then "px-4 py-2 h-9 text-sm"
        when :lg then "px-4 py-2 h-10 text-base"
        when :xl then "px-6 py-3 h-12 text-base"
        end
      end
    end

    def primary_classes
      [
        BASE_CLASSES,
        size_classes,
        PIXEL_BOX_CLASSES,
        "bg-primary text-primary-foreground",
        "hover:bg-primary/90"
      ]
    end

    def link_classes
      [
        BASE_CLASSES,
        size_classes,
        "text-primary underline-offset-4 decoration-2",
        "hover:underline"
      ]
    end

    def secondary_classes
      [
        BASE_CLASSES,
        size_classes,
        PIXEL_BOX_CLASSES,
        "bg-secondary text-secondary-foreground",
        "hover:bg-secondary/80"
      ]
    end

    def destructive_classes
      [
        BASE_CLASSES,
        size_classes,
        PIXEL_BOX_CLASSES,
        "bg-destructive text-white [--pixel-shade:rgb(0_0_0/0.3)]",
        "hover:bg-destructive/90",
        "dark:bg-destructive/60"
      ]
    end

    def outline_classes
      [
        BASE_CLASSES,
        size_classes,
        PIXEL_BOX_CLASSES,
        "bg-background",
        "hover:bg-accent hover:text-accent-foreground"
      ]
    end

    def ghost_classes
      [
        BASE_CLASSES,
        size_classes,
        "pixel-corners",
        "hover:bg-accent hover:text-accent-foreground"
      ]
    end

    def default_classes
      case @variant
      when :primary then primary_classes
      when :link then link_classes
      when :secondary then secondary_classes
      when :destructive then destructive_classes
      when :outline then outline_classes
      when :ghost then ghost_classes
      end
    end

    def default_attrs
      {type: @type, class: default_classes}
    end
  end
end
