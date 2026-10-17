PixelRuby::MCP::Engine.routes.draw do
  match "/", to: PixelRuby::MCP::RackApp, via: %i[get post delete], as: :mcp
end
