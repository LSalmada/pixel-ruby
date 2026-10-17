# pixel_ruby-mcp

Model Context Protocol (MCP) server for [Pixel Ruby](https://rubyui.com). Lets AI coding agents discover, inspect, and install Pixel Ruby components.

Hosted endpoint: **https://www.rubyui.com/mcp**

## Tools

| Tool | Purpose |
|------|---------|
| `get_project_registries` | List available registries (always returns `pixel_ruby`). |
| `list_items_in_registries` | All components with descriptions. |
| `search_items_in_registries` | Fuzzy search by name, description, or docs. |
| `view_items_in_registries` | Full source + dependencies for given components. |
| `get_item_examples_from_registries` | Code examples per component. |
| `get_add_command_for_items` | Validated `rails g pixel_ruby:component …` command. |
| `get_audit_checklist` | Post-install verification checklist. |

## Architecture

- Rails engine gem, sibling of `gem/` and `docs/` in the monorepo.
- Static `data/registry.json` built from `../gem/` by `exe/pixel-ruby-mcp-build`, committed to the repo.
- Mounted inside the `docs/` Rails app at `/mcp` via `PixelRuby::MCP::Engine`.
- HTTP transport via `mcp` ruby-sdk (`StreamableHTTPTransport`).
- Read-only; component installs happen client-side via the Pixel Ruby generator.

## Development

```bash
cd mcp
bundle install
bundle exec rake test
```

Rebuild the registry from the sibling gem:

```bash
bundle exec exe/pixel-ruby-mcp-build
```

CI verifies the committed `data/registry.json` matches a fresh build (`mcp-registry-check` job).

## Client setup

See https://rubyui.com/docs/mcp for per-client install snippets (Claude Code, Cursor, Claude Desktop, Windsurf, VS Code, Zed).
