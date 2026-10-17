# frozen_string_literal: true

require "test_helper"

class PixelRuby::ToastTest < ComponentTest
  def test_compose_region_with_item_and_slots
    out = phlex {
      PixelRuby.ToastRegion {
        PixelRuby.ToastItem(variant: :success) {
          PixelRuby.ToastIcon(variant: :success)
          PixelRuby.ToastTitle { "Saved" }
          PixelRuby.ToastDescription { "All good" }
          PixelRuby.ToastAction(label: "Undo", on: "click->thing#undo")
          PixelRuby.ToastClose()
        }
      }
    }
    assert_match(/Saved/, out)
    assert_match(/All good/, out)
    assert_match(/Undo/, out)
    assert_match(/data-slot="close"/, out)
    assert_match(/data-slot="icon"/, out)
  end

  def test_flash_variant_helper
    assert_equal :info, PixelRuby::Toast.flash_variant(:notice)
    assert_equal :warning, PixelRuby::Toast.flash_variant("alert")
    assert_equal :default, PixelRuby::Toast.flash_variant(:unknown)
  end

  def test_action_renders_label_and_action_attr
    out = phlex { PixelRuby.ToastAction(label: "Undo", on: "click->thing#undo") }
    assert_match(/Undo/, out)
    assert_match(/data-slot="action"/, out)
    assert_match(/data-action="click->thing#undo"/, out)
  end

  def test_cancel_renders_label_and_dismiss_action
    out = phlex { PixelRuby.ToastCancel(label: "Dismiss") }
    assert_match(/Dismiss/, out)
    assert_match(/data-slot="cancel"/, out)
    assert_match(/click-&gt;pixel-ruby--toast#dismiss|click->pixel-ruby--toast#dismiss/, out)
  end

  def test_icon_renders_per_variant
    {
      success: /circle[^>]*r="10"/,
      info: /M12 16v-4/,
      warning: /m21\.73 18/,
      error: /6\.624a2 2 0 0 1 1\.414/,
      loading: /animate-spin/
    }.each do |variant, pattern|
      out = phlex { PixelRuby.ToastIcon(variant: variant) }
      assert_match(pattern, out, "expected #{variant} icon to match #{pattern.inspect}")
    end
  end

  def test_icon_default_variant_renders_nothing
    out = phlex { PixelRuby.ToastIcon(variant: :default) }
    refute_match(/<svg/, out)
  end

  def test_close_renders_dismiss_action
    out = phlex { PixelRuby.ToastClose() }
    assert_match(/data-slot="close"/, out)
    assert_match(/click-&gt;pixel-ruby--toast#dismiss|click->pixel-ruby--toast#dismiss/, out)
    assert_match(/sr-only/, out)
  end

  def test_title_and_description_slot_attrs
    title_out = phlex { PixelRuby.ToastTitle { "Saved" } }
    desc_out = phlex { PixelRuby.ToastDescription { "details" } }
    assert_match(/data-slot="title"/, title_out)
    assert_match(/Saved/, title_out)
    assert_match(/data-slot="description"/, desc_out)
    assert_match(/details/, desc_out)
  end
end
