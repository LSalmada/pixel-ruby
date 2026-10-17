require "rails/generators"
require_relative "../javascript_utils"

module PixelRuby
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include PixelRuby::Generators::JavascriptUtils

      namespace "pixel_ruby:install"

      source_root File.expand_path("templates", __dir__)

      def install_phlex_rails
        say "Checking for phlex-rails"

        if gem_installed?("phlex-rails")
          say "phlex-rails is already installed", :green
        else
          say "Adding phlex-rails to Gemfile"
          run %(bundle add phlex-rails)

          say "Generating phlex-rails structure"
          run "bin/rails generate phlex:install"
        end
      end

      def install_tailwind_merge
        say "Checking for tailwind_merge"

        if gem_installed?("tailwind_merge")
          say "tailwind_merge is already installed", :green
        else
          say "Adding tailwind_merge to Gemfile"
          run %(bundle add tailwind_merge)
        end
      end

      def install_pixel_ruby_initializer
        say "Creating PixelRuby initializer"
        template "pixel_ruby.rb.erb", Rails.root.join("config/initializers/pixel_ruby.rb")
      end

      def add_pixel_ruby_module_to_components_base
        say "Adding PixelRuby Kit to Components::Base"
        insert_into_file Rails.root.join("app/components/base.rb"), after: "class Components::Base < Phlex::HTML" do
          "\n  include PixelRuby"
        end
      end

      def add_tailwind_css
        say "Adding Tailwind css"

        css_path = if using_importmap?
          Rails.root.join("app/assets/tailwind/application.css")
        else
          Rails.root.join("app/assets/stylesheets/application.tailwind.css")
        end

        template "tailwind.css.erb", css_path
      end

      def install_tailwind_plugins
        say "Installing tw-animate-css plugin"
        install_js_package("tw-animate-css")
      end

      def add_pixel_ruby_base
        say "Adding PixelRuby::Base component"
        template "../../../../pixel_ruby/base.rb", Rails.root.join("app/components/pixel_ruby/base.rb")
      end

      private

      def gem_installed?(name)
        Gem::Specification.find_all_by_name(name).any?
      end

      def using_tailwindcss_rails_gem?
        File.exist?(Rails.root.join("app/assets/tailwind/application.css"))
      end
    end
  end
end
