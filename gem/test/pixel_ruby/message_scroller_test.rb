# frozen_string_literal: true

require "test_helper"

class PixelRuby::MessageScrollerTest < ComponentTest
  def test_renders_full_structure
    output = phlex do
      PixelRuby.MessageScrollerProvider do
        PixelRuby.MessageScroller do
          PixelRuby.MessageScrollerViewport do
            PixelRuby.MessageScrollerContent do
              PixelRuby.MessageScrollerItem { "row" }
            end
          end
          PixelRuby.MessageScrollerButton
        end
      end
    end

    assert_match(/data-controller="pixel-ruby--message-scroller"/, output)
    assert_match(/data-slot="message-scroller"/, output)
    assert_match(/data-slot="message-scroller-viewport"/, output)
    assert_match(/data-slot="message-scroller-content"/, output)
    assert_match(/data-slot="message-scroller-item"/, output)
    assert_match(/data-slot="message-scroller-button"/, output)
  end

  def test_provider_values_default
    output = phlex { PixelRuby.MessageScrollerProvider { "x" } }

    assert_match(/message-scroller-auto-scroll-value="true"/, output)
    assert_match(/message-scroller-previous-item-peek-value="64"/, output)
    assert_match(/message-scroller-default-position-value="end"/, output)
    assert_match(/message-scroller-preserve-on-prepend-value="true"/, output)
  end

  def test_provider_values_custom
    output = phlex do
      PixelRuby.MessageScrollerProvider(auto_scroll: false, previous_item_peek: 32, default_position: :last_anchor) { "x" }
    end

    assert_match(/message-scroller-auto-scroll-value="false"/, output)
    assert_match(/message-scroller-previous-item-peek-value="32"/, output)
    assert_match(/message-scroller-default-position-value="last-anchor"/, output)
  end

  def test_content_live_region
    output = phlex { PixelRuby.MessageScrollerContent { "x" } }

    assert_match(/role="log"/, output)
    assert_match(/aria-relevant="additions text"/, output)
  end

  def test_item_scroll_anchor_and_message_id
    output = phlex do
      PixelRuby.MessageScrollerItem(scroll_anchor: true, message_id: "m1") { "row" }
    end

    assert_match(/data-scroll-anchor/, output)
    assert_match(/data-message-id="m1"/, output)
  end

  def test_item_without_anchor
    output = phlex { PixelRuby.MessageScrollerItem { "row" } }

    refute_match(/data-scroll-anchor/, output)
  end

  def test_button_targets_and_action
    output = phlex { PixelRuby.MessageScrollerButton }

    assert_match(/message-scroller-target="button"/, output)
    assert_match(/click->pixel-ruby--message-scroller#jump/, output)
    assert_match(/data-direction="end"/, output)
    assert_match(/Scroll to end/, output)
  end

  def test_button_start_direction
    output = phlex { PixelRuby.MessageScrollerButton(direction: :start) }

    assert_match(/data-direction="start"/, output)
    assert_match(/Scroll to start/, output)
  end
end
