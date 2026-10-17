# frozen_string_literal: true

require "test_helper"

class PixelRuby::MessageTest < ComponentTest
  def test_renders_message_with_bubble
    output = phlex do
      PixelRuby.Message do
        PixelRuby.MessageContent do
          PixelRuby.Bubble { PixelRuby.BubbleContent { "Hi" } }
        end
      end
    end

    assert_match(/data-slot="message"/, output)
    assert_match(/data-slot="message-content"/, output)
    assert_match(/data-slot="bubble"/, output)
    assert_match(/Hi/, output)
  end

  def test_default_align_start
    output = phlex { PixelRuby.Message { "x" } }

    assert_match(/data-align="start"/, output)
  end

  def test_align_end
    output = phlex { PixelRuby.Message(align: :end) { "x" } }

    assert_match(/data-align="end"/, output)
  end

  def test_avatar_header_footer_slots
    output = phlex do
      PixelRuby.Message do
        PixelRuby.MessageAvatar { "A" }
        PixelRuby.MessageContent do
          PixelRuby.MessageHeader { "Oliver" }
          PixelRuby.Bubble { PixelRuby.BubbleContent { "Hi" } }
          PixelRuby.MessageFooter { "Delivered" }
        end
      end
    end

    assert_match(/data-slot="message-avatar"/, output)
    assert_match(/data-slot="message-header"/, output)
    assert_match(/data-slot="message-footer"/, output)
  end

  def test_group_wraps_messages
    output = phlex do
      PixelRuby.MessageGroup do
        PixelRuby.Message { "a" }
        PixelRuby.Message { "b" }
      end
    end

    assert_match(/data-slot="message-group"/, output)
  end
end
