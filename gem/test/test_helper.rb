# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "pixel_ruby"
require "phlex"
require "json"
require "securerandom"
require "minitest/autorun"

module PixelRuby
  extend Phlex::Kit

  Dir.glob("lib/pixel_ruby/**/*.rb").reject { |f| f.include?("/docs/") || f.end_with?("_docs.rb") }.map do |path|
    class_name = path.split("/").last.delete_suffix(".rb").split("_").map(&:capitalize).join.to_sym

    autoload class_name, path
  end
end

class ComponentTest < Minitest::Test
  def render(component, &)
    component.call(&)
  end

  def phlex(&)
    render Phlex::HTML.new, &
  end
end

# this is a tracepoint that will output the path of all files loaded that contain the string "phlex"
# trace = TracePoint.new(:class) do |tp|
#   puts "Loaded: #{tp.path}" if tp.path.include?("phlex")
# end
# trace.enable
