# CLAUDE.md

Guidance for AI agents working at the root of the `ruby-ui/ruby_ui` monorepo.

## Layout

Two sibling projects, each independent (own `Gemfile`, `package.json`, tests, lockfiles):

| Path | What it is |
| --- | --- |
| [`gem/`](gem/) | The `pixel_ruby` gem — Phlex components, generators, gemspec, Minitest suite. Published to RubyGems from here. |
| [`docs/`](docs/) | Rails 8 app powering https://rubyui.com. Consumes the local gem via `path: "../gem"`. |
| `.github/workflows/ci.yml` | Unified CI: gem tests (Ruby 3.3 + 3.4), docs Rails tests, docker build for docs devcontainer. |

Subproject-specific instructions live in `gem/AGENTS.md` and `docs/CLAUDE.md` (→ `docs/AGENTS.md`). Read those before editing inside a subdir.

## Routing changes

- Component code → `gem/lib/pixel_ruby/<component>/`. Tests → `gem/test/pixel_ruby/<component>_test.rb`.
- Component docs view → `docs/app/views/docs/<component>.rb`. Update in same PR as the component.
- Generator/installer logic → `gem/lib/generators/pixel_ruby/`. Dependency map → `gem/lib/generators/pixel_ruby/dependencies.yml`.
- Site chrome, routes, marketing pages → `docs/app/`.
- A component's Stimulus controller lives only in `gem/lib/pixel_ruby/<component>/<component>_controller.js`. `docs/app/javascript/controllers/pixel_ruby/<component>_controller.js` is a symlink to it, not a copy — editing the gem file is enough for existing components. A brand-new component's controller needs `docs`' `rake pixel_ruby:sync_controller_symlinks` to create the symlink, plus `bin/rails stimulus:manifest:update` to register it.

## Common commands

Run from the relevant subdir, not root.

```bash
# Gem
cd gem
bundle exec rake                                  # tests + standardrb
bundle exec rake test TEST=test/pixel_ruby/button_test.rb
bundle exec standardrb --fix

# Docs site
cd docs
bin/setup
bin/dev                                           # local server
pnpm build && pnpm build:css                      # assets
bin/rails db:test:prepare test
bundle exec standardrb
```

## Conventions

- Ruby 3.2+, 2-space indent, `snake_case` files/methods, `CamelCase` classes. StandardRB enforced.
- Components extend `PixelRuby::Base < Phlex::HTML`; classes merged via `tailwind_merge`. Invoke as `PixelRuby.<Name>()` (Phlex::Kit).
- Stimulus controllers colocated with components: `<component>_controller.js`. JS deps declared in `gem/package.json` and per-component in `dependencies.yml`.
- Tests extend `ComponentTest`; render via `phlex { ... }` helper.

## Releasing

A release is **not done** until all four steps below are complete. Skipping the publish, the docs/website reflection, or the git tag leaves the release half-finished.

Decide the bump with SemVer against commits since the last `vX.Y.Z` tag: new backward-compatible features → **minor**; bug fixes / docs only → **patch**. List the range with `git log --oneline vX.Y.Z..HEAD`.

1. **Bump the version (gem).** Edit `PixelRuby::VERSION` in `gem/lib/pixel_ruby.rb`. Then from each app dir regenerate lockfiles so the path dependency tracks the new version: `gem/Gemfile.lock` and `docs/Gemfile.lock` should both read `pixel_ruby (X.Y.Z)`.

2. **Publish the gem to RubyGems.** From `gem/`: `gem build pixel_ruby.gemspec` then `gem push pixel_ruby-X.Y.Z.gem`. The account has **MFA**, so `gem push` prompts for a one-time password — have the OTP ready (or pass `--otp <CODE>`). Confirm the publishing account is listed in `gem owner pixel_ruby` first. Do not commit the built `.gem` artifact.

3. **Reflect the version on the docs website (PR against `main`).** Releases go through a `[Release] vX.Y.Z` PR (main is protected — no direct pushes). The PR bundles, on a `release/vX.Y.Z` branch:
   - the `gem/lib/pixel_ruby.rb` bump + both regenerated `Gemfile.lock`s;
   - `docs/app/views/pages/home.rb` — update the home hero badge copy to the headline features (the header version badge reads `PixelRuby::VERSION` and updates automatically; do not hardcode it);
   - `mcp/data/registry.json` — rebuild with `cd mcp && bundle exec rake mcp:build` (reads `../gem`, so it picks up the new version).

4. **Tag + GitHub release.** After the release PR merges, tag `vX.Y.Z` on the merge commit, push the tag, and cut the GitHub release. The git tag and the published gem must both exist — publishing the gem without tagging (or vice versa) is an incomplete release.

5. **Hand over the announcement URL (final step).** As the last step, give the user a ready-to-post X.com (Twitter) share link for the PixelRuby account — the user posts it manually. Use the prefilled-tweet intent URL with the body URL-encoded:

   ```
   https://x.com/intent/post?text=RubyUI%20X.Y.Z%20released%21%20%F0%9F%9A%80%0A%0Ahttps%3A%2F%2Fwww.rubyui.com%2Fdocs%2Fchangelog
   ```

   which decodes to:

   ```
   PixelRuby X.Y.Z released! 🚀

   https://www.rubyui.com/docs/changelog
   ```

   Substitute the real full `X.Y.Z` (e.g. `1.4.0`) in the encoded `text` — always include all three numbers so patch releases get announced too. Output the link so the user can open and post it.

## Commits & PRs

- Bracketed prefixes (`[Feature]`, `[Bug Fix]`, `[Documentation]`) or scoped conventional (`feat(scope): ...`).
- Imperative, focused commits. Reference issues/PRs as `(#123)`.
- PRs: linked issue, concise description, before/after screenshots for UI changes, explicit test steps.

## Don'ts

- Don't run commands from repo root expecting them to work — `cd gem` or `cd docs` first.
- Don't edit a component without updating its `docs/app/views/docs/<component>.rb` counterpart.
- Don't bump the gem version from `docs/`; `PixelRuby::VERSION` lives in `gem/lib/pixel_ruby.rb` and the gem is published from `gem/`. (The release PR also reflects the version into `docs/` and `mcp/` — see [Releasing](#releasing).)
- Don't call a release done after only publishing the gem — tag `vX.Y.Z` and reflect the version on the website too.
- Don't commit secrets; each app uses local env config.
