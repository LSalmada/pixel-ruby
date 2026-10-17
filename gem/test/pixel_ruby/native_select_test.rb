# frozen_string_literal: true

require "test_helper"

class PixelRuby::NativeSelectTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.NativeSelect(name: "department") do
        PixelRuby.NativeSelectOption(value: "") { "Select a department" }
        PixelRuby.NativeSelectGroup(label: "Engineering") do
          PixelRuby.NativeSelectOption(value: "frontend") { "Frontend" }
          PixelRuby.NativeSelectOption(value: "backend") { "Backend" }
        end
        PixelRuby.NativeSelectGroup(label: "Sales") do
          PixelRuby.NativeSelectOption(value: "account_executive") { "Account Executive" }
        end
      end
    end

    assert_match(/Frontend/, output)
    assert_match('name="department"', output)
  end
end
