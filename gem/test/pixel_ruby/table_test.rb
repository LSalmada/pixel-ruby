# frozen_string_literal: true

require "test_helper"

class PixelRuby::TableTest < ComponentTest
  def test_render_with_all_items
    invoices = [
      {identifier: "INV-0001", status: "Active", method: "Credit Card", amount: 100},
      {identifier: "INV-0002", status: "Active", method: "Bank Transfer", amount: 230},
      {identifier: "INV-0003", status: "Pending", method: "PayPal", amount: 350},
      {identifier: "INV-0004", status: "Inactive", method: "Credit Card", amount: 100}
    ]

    output = phlex do
      PixelRuby.Table do
        PixelRuby.TableCaption { "Employees at Acme inc." }
        PixelRuby.TableHeader do
          PixelRuby.TableRow do
            PixelRuby.TableHead { "Name" }
            PixelRuby.TableHead { "Email" }
            PixelRuby.TableHead { "Status" }
            PixelRuby.TableHead(class: "text-right") { "Role" }
          end
        end
        PixelRuby.TableBody do
          invoices.each do |invoice|
            PixelRuby.TableRow do
              PixelRuby.TableCell(class: "font-medium") { invoice[:identifier] }
              PixelRuby.TableCell { invoice[:status] }
              PixelRuby.TableCell { invoice[:method] }
              PixelRuby.TableCell(class: "text-right") { invoice[:amount] }
            end
          end
        end
        PixelRuby.TableFooter do
          PixelRuby.TableRow do
            PixelRuby.TableHead(class: "font-medium", colspan: 3) { "Total" }
            PixelRuby.TableHead(class: "font-medium text-right") { invoices.sum { |invoice| invoice[:amount] } }
          end
        end
      end
    end

    assert_match(/Total/, output)
  end
end
