# frozen_string_literal: true

require "pixel_ruby"

module PixelRuby
  extend Phlex::Kit
end

# Autoload PixelRuby components directly from the gem's lib/pixel_ruby directory
# (the gem lives at ../gem in this monorepo, resolved via Bundler).
gem_pixel_ruby_path = "#{Gem.loaded_specs["pixel_ruby"].gem_dir}/lib/pixel_ruby"

Rails.autoloaders.main.push_dir(gem_pixel_ruby_path, namespace: PixelRuby)
Rails.autoloaders.main.collapse(
  Dir.glob("#{gem_pixel_ruby_path}/*").select { |p| File.directory?(p) && File.basename(p) != "docs" }
)

# The gem ships *_docs.rb files (Views::Docs::*) and a docs/ scaffolding folder
# (Docs::*). The Rails docs app has its own richer implementations under
# app/views/docs and app/components/docs, so we ignore the gem versions to
# avoid Zeitwerk namespace mismatches.
Rails.autoloaders.main.ignore("#{gem_pixel_ruby_path}/docs")
Dir.glob("#{gem_pixel_ruby_path}/**/*_docs.rb").each do |f|
  Rails.autoloaders.main.ignore(f)
end
