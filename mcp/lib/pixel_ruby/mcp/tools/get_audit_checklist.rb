# frozen_string_literal: true

require "pixel_ruby/mcp/tools/base"

module PixelRuby
  module MCP
    module Tools
      class GetAuditChecklist < Base
        CHECKLIST = [
          {check: "gem_in_gemfile", description: "`pixel_ruby` gem present in Gemfile."},
          {check: "components_copied", description: "Component files exist under app/components/pixel_ruby/<name>/."},
          {check: "stimulus_registered", description: "Stimulus controllers registered (where applicable)."},
          {check: "js_packages_installed", description: "JS packages from dependencies.yml present in package.json."},
          {check: "tailwind_content_paths", description: "Tailwind content config includes app/components/pixel_ruby/**/*."},
          {check: "zeitwerk_loads", description: "Zeitwerk loads the PixelRuby namespace without errors."},
          {check: "views_compile", description: "Generated Phlex views render without errors."}
        ].freeze

        def call(**)
          {checklist: CHECKLIST}
        end
      end
    end
  end
end
