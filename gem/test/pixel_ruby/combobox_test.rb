# frozen_string_literal: true

require "test_helper"

class PixelRuby::ComboboxTest < ComponentTest
  def test_render_with_radio_items
    output = phlex do
      PixelRuby.Combobox(multiple: true, term: "frameworks") do
        PixelRuby.ComboboxTrigger placeholder: "Select your framework"

        PixelRuby.ComboboxPopover do
          PixelRuby.ComboboxSearchInput(placeholder: "Type the framework name")

          PixelRuby.ComboboxList do
            PixelRuby.ComboboxEmptyState { "No results" }

            PixelRuby.ComboboxListGroup label: "Ruby" do
              PixelRuby.ComboboxItem do
                PixelRuby.ComboboxRadio(name: "Rails", value: "rails")
              end
              PixelRuby.ComboboxItem do
                PixelRuby.ComboboxRadio(name: "Hanami", value: "hanami")
              end
            end

            PixelRuby.ComboboxItem do
              PixelRuby.ComboboxRadio(name: "Lucky", value: "lucky")
            end
            PixelRuby.ComboboxItem do
              PixelRuby.ComboboxRadio(name: "Kemal", value: "kemal")
            end
          end
        end
      end
    end

    assert_match(/Hanami/, output)
  end

  def test_render_with_checkbox_items
    output = phlex do
      PixelRuby.Combobox(multiple: true, term: "frameworks") do
        PixelRuby.ComboboxTrigger placeholder: "Select your framework"

        PixelRuby.ComboboxPopover do
          PixelRuby.ComboboxSearchInput(placeholder: "Type the framework name")

          PixelRuby.ComboboxList do
            PixelRuby.ComboboxEmptyState { "No results" }

            PixelRuby.ComboboxListGroup label: "Ruby" do
              PixelRuby.ComboboxItem do
                PixelRuby.ComboboxCheckbox(name: "Rails", value: "rails")
              end
              PixelRuby.ComboboxItem do
                PixelRuby.ComboboxCheckbox(name: "Hanami", value: "hanami")
              end
            end

            PixelRuby.ComboboxItem do
              PixelRuby.ComboboxCheckbox(name: "Lucky", value: "lucky")
            end
            PixelRuby.ComboboxItem do
              PixelRuby.ComboboxCheckbox(name: "Kemal", value: "kemal")
            end
          end
        end
      end
    end

    assert_match(/Hanami/, output)
  end

  def test_combobox_item_renders_expected_role_and_state_classes
    output = phlex { PixelRuby.ComboboxItem { PixelRuby.ComboboxRadio(name: "x", value: "1") } }
    assert_match(/role="option"/, output)
    assert_match(/has-\[:checked\]:bg-accent/, output)
    assert_match(/aria-\[current=true\]:ring/, output)
  end

  def test_combobox_radio_renders_styled_input
    output = phlex { PixelRuby.ComboboxRadio(name: "x", value: "1") }
    assert_match(/rounded-full/, output)
    assert_match(/border-primary/, output)
    assert_match(/checked:bg-primary/, output)
  end

  def test_combobox_checkbox_renders_styled_input
    output = phlex { PixelRuby.ComboboxCheckbox(name: "x", value: "1") }
    assert_match(/\bpeer\b/, output)
    assert_match(/rounded-sm border/, output)
    assert_match(/checked:bg-primary/, output)
  end

  def test_combobox_checkbox_wires_checkbox_group_and_form_field
    output = phlex { PixelRuby.ComboboxCheckbox(name: "x", value: "1") }
    assert_match(/data-pixel-ruby--checkbox-group-target="checkbox"/, output)
    assert_match(/data-pixel-ruby--form-field-target="input"/, output)
    assert_match(/change->pixel-ruby--checkbox-group#onChange/, output)
    assert_match(/change->pixel-ruby--form-field#onInput/, output)
    assert_match(/invalid->pixel-ruby--form-field#onInvalid/, output)
  end

  def test_combobox_item_indicator_renders_check_svg
    output = phlex { PixelRuby.ComboboxItemIndicator() }
    assert_match(/peer-checked:opacity-100/, output)
    assert_match(/opacity-0/, output)
    assert_match(/M20 6 9 17l-5-5/, output)
  end

  def test_combobox_badge_trigger_renders_targets
    output = phlex { PixelRuby.ComboboxBadgeTrigger() }
    assert_match(/badgeContainer/, output)
    assert_match(/badgeInput/, output)
    assert_match(/openPopover/, output)
  end

  def test_combobox_badge_renders_span
    output = phlex { PixelRuby.ComboboxBadge { "Item" } }
    assert_match(/bg-secondary/, output)
    assert_match(/Item/, output)
    assert_match(/<span/, output)
  end

  def test_combobox_clear_button_renders
    output = phlex { PixelRuby.ComboboxClearButton() }
    assert_match(/clearAll/, output)
    assert_match(/\bhidden\b/, output)
    assert_match(/clearButton/, output)
  end

  def test_combobox_item_has_hover_state
    output = phlex { PixelRuby.ComboboxItem { PixelRuby.ComboboxRadio(name: "x", value: "1") } }
    assert_match(/hover:bg-accent/, output)
  end

  def test_combobox_item_has_keyboard_highlight
    output = phlex { PixelRuby.ComboboxItem { PixelRuby.ComboboxRadio(name: "x", value: "1") } }
    assert_match(/aria-\[current=true\]:bg-accent/, output)
  end

  def test_combobox_item_has_disabled_state
    output = phlex { PixelRuby.ComboboxItem { PixelRuby.ComboboxRadio(name: "x", value: "1") } }
    assert_match(/has-disabled:opacity-50/, output)
  end

  def test_combobox_toggle_all_checkbox_renders_styled_input
    output = phlex { PixelRuby.ComboboxToggleAllCheckbox() }
    assert_match(/\bpeer\b/, output)
    assert_match(/rounded-sm border/, output)
    assert_match(/change->pixel-ruby--combobox#toggleAllItems/, output)
  end

  def test_combobox_input_trigger_renders
    output = phlex { PixelRuby.ComboboxInputTrigger(placeholder: "Pick one") }
    assert_match(/inputTrigger/, output)        # inputTrigger target on input
    assert_match(/trigger/, output)             # trigger target on wrapper
    assert_match(/Pick one/, output)            # placeholder
    assert_match(/openPopover/, output)         # focus action
    assert_match(/filterItems/, output)         # keyup action
    assert_match(/path.*d="m6 9 6 6 6-6"/, output) # chevron-down SVG present
  end

  def test_combobox_input_trigger_invalid_state
    output = phlex { PixelRuby.ComboboxInputTrigger(aria: {invalid: "true"}, placeholder: "Pick") }
    assert_match(/aria-invalid.*true|invalid.*true/, output)
    assert_match(/aria-invalid:border-destructive/, output)
  end

  def test_combobox_clear_button_is_subtle
    output = phlex { PixelRuby.ComboboxClearButton() }
    assert_match(/text-muted-foreground/, output)
    assert_match(/focus-visible:ring-2/, output)
  end

  def test_combobox_badge_trigger_input_has_no_border
    output = phlex { PixelRuby.ComboboxBadgeTrigger(placeholder: "Select") }
    assert_match(/border-0/, output)
  end

  def test_combobox_badge_trigger_clear_button_prop
    output = phlex { PixelRuby.ComboboxBadgeTrigger(clear_button: true) }
    assert_match(/clearButton/, output)
    assert_match(/clearAll/, output)
  end

  def test_combobox_badge_trigger_no_clear_button_by_default
    output = phlex { PixelRuby.ComboboxBadgeTrigger() }
    refute_match(/clearButton/, output)
  end

  def test_combobox_badge_trigger_no_chevron
    output = phlex { PixelRuby.ComboboxBadgeTrigger() }
    refute_match(/chevron|m6 9 6 6 6-6/, output)
  end

  def test_combobox_trigger_chevron_down
    output = phlex { PixelRuby.ComboboxTrigger(placeholder: "Pick") }
    assert_match(/m6 9 6 6 6-6/, output)
  end

  def test_combobox_trigger_sets_placeholder_data
    output = phlex { PixelRuby.ComboboxTrigger(placeholder: "Pick") }
    assert_match(/data-placeholder="Pick"/, output)
  end

  def test_combobox_trigger_uses_toggle_action
    output = phlex { PixelRuby.ComboboxTrigger(placeholder: "Pick") }
    assert_match(/pixel-ruby--combobox#togglePopover/, output)
    assert_match(/h-4 w-4/, output)
  end

  def test_combobox_input_trigger_chevron_hover_effect
    output = phlex { PixelRuby.ComboboxInputTrigger(placeholder: "Pick") }
    assert_match(/hover:bg-muted/, output)
    assert_match(/size-6/, output)
    assert_match(/rounded-sm/, output)
  end

  def test_combobox_input_trigger_no_inner_padding
    output = phlex { PixelRuby.ComboboxInputTrigger(placeholder: "Pick") }
    assert_match(/px-0/, output)
  end

  def test_combobox_keyboard_actions_on_controller
    output = phlex { PixelRuby.ComboboxPopover { "" } }
    assert_match(/keydown\.down/, output)
    assert_match(/keydown\.up/, output)
    assert_match(/keydown\.enter/, output)
    assert_match(/keydown\.esc/, output)
  end

  def test_combobox_input_trigger_focusin_action
    output = phlex { PixelRuby.ComboboxInputTrigger(placeholder: "Pick") }
    assert_match(/focusin->pixel-ruby--combobox#openPopover/, output)
  end

  def test_combobox_item_has_selected_background
    output = phlex { PixelRuby.ComboboxItem { PixelRuby.ComboboxRadio(name: "x", value: "1") } }
    assert_match(/has-\[:checked\]:bg-accent/, output)
  end

  def test_combobox_item_has_ring_on_current
    output = phlex { PixelRuby.ComboboxItem { PixelRuby.ComboboxRadio(name: "x", value: "1") } }
    assert_match(/aria-\[current=true\]:ring\b/, output)
  end

  def test_combobox_popover_has_autofocus
    output = phlex { PixelRuby.ComboboxPopover { "" } }
    assert_match(/autofocus/, output)
  end
end
