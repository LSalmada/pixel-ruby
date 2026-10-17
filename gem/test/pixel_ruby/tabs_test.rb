# frozen_string_literal: true

require "test_helper"

class PixelRuby::TabsTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.Tabs(default_value: "account", class: "w-96") do
        PixelRuby.TabsList do
          PixelRuby.TabsTrigger(value: "account") { "Account" }
          PixelRuby.TabsTrigger(value: "password") { "Password" }
        end
        PixelRuby.TabsContent(value: "account") do
          PixelRuby::Text(as: "p", size: "4") { "Account" }
          PixelRuby::Text(size: "5", weight: "semibold") { "Are you sure absolutely sure?" }
          PixelRuby::Text(size: "2", class: "text-muted-foreground") { "Update your account details." }
        end
        PixelRuby.TabsContent(value: "password") do
          PixelRuby::Text(as: "p", size: "4") { "Password" }
          PixelRuby::Text(size: "2", class: "text-muted-foreground") { "Change your password here. After saving, you'll be logged out." }
        end
      end
    end

    assert_match(/Account/, output)
  end
end
