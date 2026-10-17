# frozen_string_literal: true

require "test_helper"

class PixelRuby::AlertDialogTest < ComponentTest
  def test_render_with_all_items
    output = phlex do
      PixelRuby.AlertDialog do
        PixelRuby.AlertDialogTrigger do
          PixelRuby.Button { "Show dialog" }
        end
        PixelRuby.AlertDialogContent do
          PixelRuby.AlertDialogHeader do
            PixelRuby.AlertDialogTitle { "Are you absolutely sure?" }
            PixelRuby.AlertDialogDescription { "This action cannot be undone. This will permanently delete your account and remove your data from our servers." }
          end
          PixelRuby.AlertDialogFooter do
            PixelRuby.AlertDialogCancel { "Cancel" }
            PixelRuby.AlertDialogAction { "Continue" }
          end
        end
      end
    end

    assert_match(/Show dialog/, output)
  end
end
