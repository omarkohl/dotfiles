---
name: slides
description: Create minimalistic, image-driven presentations with Slidev. Use when the user wants to make slides, a presentation, or a deck.
---

# Slides

Build presentations with [Slidev](https://sli.dev) unless the user asks for another tool.

## Setup

If no Slidev project exists yet, scaffold one: `bun create slidev@latest`. Write the deck in the generated `slides.md`.

## Content rules

- **Minimalistic.** One idea per slide. Little or no on-slide text.
- **Images over text.** Prefer an image that carries the point over a sentence explaining it.
- **Incremental text.** When text is unavoidable, reveal it piece by piece instead of showing it all at once.
- **Elaboration goes in speaker notes**, not on the slide — use a trailing HTML comment (`<!-- notes -->`) at the end of each slide for talking points.

## Slidev patterns to use

- **Slide separator**: `---` on its own line (blank line before and after) starts a new slide. Per-slide frontmatter between the separators sets that slide's `layout` and options.
- **Layouts** — pick per slide based on content, don't default to `default` everywhere:
  - `cover` / `intro` — title slide
  - `section` — divider between sections
  - `image` — image is the entire slide (`image: /path`, `backgroundSize: cover|contain`)
  - `image-left` / `image-right` — image fills one half, sparse content/caption on the other
  - `center` — short centered statement
  - `statement` / `fact` — a single bold claim or number
  - `quote` — a quotation
  - `two-cols` / `two-cols-header` — side-by-side comparison, only when genuinely needed
  - `end` — closing slide
- **Incremental reveal**:
  - `<v-click>...</v-click>` or `<div v-click>` for a single element that appears on the next click.
  - `<v-clicks>` wrapping a list to reveal each item one at a time.
  - `v-click.hide` / click ranges (`v-click="[2, 4]"`) when something should appear then later disappear.
- **Speaker notes**: an HTML comment (`<!-- ... -->`) at the very end of a slide's content is treated as presenter notes — put context, data, and things to say there instead of on the slide.

## Attendee polls

For live audience polls, quizzes, word clouds, and reactions, use
[slidev-addon-polls](https://github.com/dezhidki/slidev-addon-polls) (not on npm yet):

```bash
bun add github:dezhidki/slidev-addon-polls
```

```yaml
---
addons:
  - slidev-addon-polls
---
```

```md
<Poll question="Tabs or spaces?" :options="['Tabs', 'Spaces']" />              # choice
<Poll question="Which talk next?" :options="['Rust', 'Go']" blind />          # blind (hides live results)
<Poll question="What is 2 + 2?" :options="['3', '4', '5']" :correct="1" />    # quiz
<Poll question="One word for this lecture so far?" />                        # word cloud
<PollQr class="w-40 mx-auto" />                                              # big join QR code
```

- Give a poll an `id` if it might be reworded or moved, so answers aren't reset.
- `<PollSet :polls="[...]" />` steps through several questions on one slide (e.g. next to a code block), advancing with the normal click.
- Start with a presenter password so only you control voting: `slidev --remote=your-password`. Controls (open/close voting, reveal answer) appear in the presenter view.
- Audience scans the QR code shown on the slide, or opens `/vote`. If presenting through a tunnel (e.g. `--tunnel`), set `pollUrl` in the headmatter to the public address.

## Images

- Never invent placeholder/stock text — assume every image the user hasn't supplied already exists, and reference it in `slides.md` with a descriptive filename, stored in `public/images/` and referenced as `/images/team-collaborating.png`.
- Write a companion `images.md` next to `slides.md` listing every referenced image not supplied by the user, one entry per image. Each entry must be **self-contained** (usable on its own, copy-pasted elsewhere) and give either:
  - a description of a photo to search for on a stock photo site, or
  - a prompt for an image generator.
- Default style, unless the user specifies otherwise, repeated in full in every generator prompt (do not abbreviate or reference "as above"): no border, no text, minimalistic, loosely hand-drawn pencil sketch with watercolor highlights.
- Generate a plain placeholder for every missing image with ImageMagick, so `slidev build` doesn't fail on unresolved `<img>` imports. Never overwrite an existing file. Use `magick` if available, else `convert` (ImageMagick 6):

  ```bash
  mkdir -p public/images
  for f in <image filenames>; do
    [ -e "public/images/$f" ] || convert -size 1600x900 xc:'#e5e5e5' "public/images/$f"
  done
  ```

  Then run `slidev build` to confirm the deck builds, and delete `dist/` afterwards.
