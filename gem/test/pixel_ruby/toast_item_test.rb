# frozen_string_literal: true

require "test_helper"

class PixelRuby::ToastItemTest < ComponentTest
  def test_renders_default_variant_with_status_role
    out = phlex { PixelRuby.ToastItem { "hi" } }
    assert_match(/data-variant="default"/, out)
    assert_match(/role="status"/, out)
    assert_match(/data-controller="pixel-ruby--toast"/, out)
    assert_match(/data-pixel-ruby--toaster-target="toast"/, out)
    assert_match(/data-state="pending"/, out)
  end

  def test_error_variant_uses_alert_role
    out = phlex { PixelRuby.ToastItem(variant: :error) { "x" } }
    assert_match(/role="alert"/, out)
    assert_match(/data-variant="error"/, out)
  end

  def test_duration_propagated_as_data_value
    out = phlex { PixelRuby.ToastItem(duration: 7000) { "x" } }
    assert_match(/data-pixel-ruby--toast-duration-value="7000"/, out)
  end

  def test_dismissible_default_true
    out = phlex { PixelRuby.ToastItem { "x" } }
    assert_match(/data-pixel-ruby--toast-dismissible-value="true"/, out)
  end

  def test_id_attribute
    out = phlex { PixelRuby.ToastItem(id: "abc") { "x" } }
    assert_match(/id="abc"/, out)
  end
end
