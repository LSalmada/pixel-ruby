# Phlex ↔ Stimulus wiring conventions (pixel_ruby)

How PixelRuby components connect their Phlex markup to Stimulus controllers. All
examples are real code from `gem/lib/pixel_ruby/`.

## Naming table

A component lives in a snake_case folder; its Stimulus identifier is the folder
path with `/` → `--` (so the `pixel_ruby/` namespace becomes the `pixel-ruby--`
prefix). Phlex converts each `_` in an attribute key to `-`, so `__` becomes
`--` in the emitted HTML.

| Thing | Folder / Ruby | Stimulus identifier | HTML attribute emitted |
| --- | --- | --- | --- |
| Controller | `popover/` → `popover_controller.js` | `pixel-ruby--popover` | `data-controller="pixel-ruby--popover"` |
| Target `trigger` | `pixel_ruby__popover_target: "trigger"` | — | `data-pixel-ruby--popover-target="trigger"` |
| Value `open` | `pixel_ruby__popover_open_value: "false"` | `openValue` | `data-pixel-ruby--popover-open-value="false"` |
| Action | `action: "click->pixel-ruby--popover#toggle"` | — | `data-action="click->pixel-ruby--popover#toggle"` |
| Outlet | `pixel_ruby__select_pixel_ruby__select_item_outlet: ".item"` | — | `data-pixel-ruby--select-pixel-ruby--select-item-outlet=".item"` |

The controller file itself is anonymous (`export default class extends
Controller`); the identifier comes from **where it is registered**, not from the
file. See "Registration" below.

## Two ways to write `data:` in `default_attrs`

Both are valid Phlex and both appear in the codebase. Pick one per component and
be consistent.

**Nested hash** (most common — `popover.rb`, `clipboard.rb`, `select.rb`):

```ruby
# gem/lib/pixel_ruby/clipboard/clipboard.rb
def default_attrs
  {
    data: {
      controller: "pixel-ruby--clipboard",
      action: "click@window->pixel-ruby--clipboard#onClickOutside",
      pixel_ruby__clipboard_success_value: @success,
      pixel_ruby__clipboard_error_value: @error,
      pixel_ruby__clipboard_options_value: @options.to_json
    }
  }
end
```

**Flattened keys** (`dialog_content.rb`) — the whole `data-...` name is one key:

```ruby
# gem/lib/pixel_ruby/dialog/dialog_content.rb
def default_attrs
  {
    data_pixel_ruby__dialog_target: "dialog",
    data_action: "click->pixel-ruby--dialog#backdropClick",
    class: [...]
  }
end
```

`default_attrs` is merged with the caller's attributes by `Base#initialize`
(`gem/lib/pixel_ruby/base.rb`) via Phlex `mix`, with Tailwind classes deduped by
`TailwindMerge`. So callers can add/override `data-*` and classes without
clobbering the component's wiring.

## Values

Pass values as strings/JSON from Ruby; declare their type in the controller:

```ruby
# popover.rb
pixel_ruby__popover_options_value: @options.to_json      # Object value → JSON string
pixel_ruby__popover_trigger_value: @options[:trigger] || "hover"
```

```js
// popover_controller.js
static values = {
  open: { type: Boolean, default: false },
  options: { type: Object, default: {} },   // parsed from the JSON string
  trigger: { type: String, default: "hover" },
};
```

React to changes with the auto-called `<name>Changed(newVal, oldVal)` callback
rather than polling.

## Targets

Child/sub-components mark themselves as targets of the parent controller:

```ruby
# select_item.rb — an item is a target of the pixel-ruby--select controller
data: {
  controller: "pixel-ruby--select-item",
  action: "click->pixel-ruby--select#selectItem keydown.enter->pixel-ruby--select#selectItem ...",
  pixel_ruby__select_target: "item"
}
```

Multiple actions go in a single space-separated string, as above.

## Actions on non-element scopes

Use `@window` / `@document` scope for outside-click and global handlers:

```ruby
# clipboard.rb
action: "click@window->pixel-ruby--clipboard#onClickOutside"
# select.rb
action: "click@window->pixel-ruby--select#clickOutside"
```

A trigger sub-component can dispatch to an ancestor controller without declaring
its own `controller:` — it relies on the parent controller being on an ancestor
element:

```ruby
# dialog_trigger.rb
data: { action: "click->pixel-ruby--dialog#open" }
```

## Outlets (parent ↔ child controllers)

The parent declares the outlet selector; the child is a separate controller the
parent can call into:

```ruby
# select.rb — parent declares the outlet to select-item
data: {
  controller: "pixel-ruby--select",
  pixel_ruby__select_pixel_ruby__select_item_outlet: ".item"
}
```

Outlet attribute shape: `data-<controller>-<outlet-identifier>-outlet`, hence the
doubled `pixel_ruby__…_pixel_ruby__…_outlet` key in Ruby.

## Registration

- **Importmap** apps (Rails default): controllers are eager-loaded from
  `controllers/` — nothing to register manually.
- **esbuild/webpack** apps: the manifest `docs/app/javascript/controllers/index.js`
  is auto-generated; regenerate with `rake stimulus:manifest:update`. Each entry is:

  ```js
  import PixelRuby__PopoverController from "./pixel_ruby/popover_controller"
  application.register("pixel-ruby--popover", PixelRuby__PopoverController)
  ```

  Note the file path segment `pixel_ruby/` + `popover_controller` maps to identifier
  `pixel-ruby--popover`.

## Dependencies

Declare any JS package the controller imports (e.g. `@floating-ui/dom`,
`fuse.js`, `embla-carousel`) in two places:

- `gem/package.json` — for the gem's own dev/test.
- `gem/lib/generators/pixel_ruby/dependencies.yml` — per-component map so the
  generator installs it into consumer apps (also lists required gems and other
  components a component depends on).
