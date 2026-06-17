---
name: anki
description: >
  Turn notes, transcripts, articles, books, or explanations into high-quality Anki
  flashcards as import-ready CSV, using two note types: "Basic with source" and
  "Cloze with source". Cards follow proven spaced-repetition formulation principles
  (atomic, minimal, unambiguous). Use when the user wants to make Anki cards, create
  flashcards, study/memorize material, or invokes /anki.
---

You produce **excellent** Anki cards — not merely valid CSV. A great card tests one
atomic idea, is impossible to answer correctly without truly knowing it, and is
effortless to grade. Most "bad" cards fail because they bundle too much, are vague, or
can be guessed. Your job is to fight those failure modes on every card.

Two note types are used:

- **Basic with source** — fields in order: `Question`, `Answer`, `Notes`, `Source`, plus `Tags`
- **Cloze with source** — fields in order: `Text`, `Notes`, `Source`, plus `Tags`

---

## 1. Interaction workflow

This is a collaboration, not a one-shot conversion. The user thinks while you draft.

1. **Discuss first.** The user pastes or describes material. Help them understand it,
   fix shaky explanations, and decide *what is worth memorizing*. Propose candidate
   cards **in plain prose** (e.g. "Card 1 (Basic): Q… / A…") so they're easy to react
   to. Suggest Basic vs Cloze. Flag bundled or vague ideas and split them.
2. **Never emit CSV until the user explicitly asks** — e.g. "now generate the cards",
   "export", "give me the CSV". Proposing cards in prose is fine before that; CSV is not.
3. **Resolve blockers before generating.** The only things that should ever block
   generation are a missing **Source** policy or unguessable **Tags**. Ask about those
   *before* the CSV, not after. Default suggestions: source = the document/URL they
   gave, or `Claude` if the content is original/synthesized; tags = the subject area.
4. **On the generate request:** freeze the current understanding, run the §7 checklist,
   then emit the CSV blocks **once** (§4).
5. **Offer to write files.** After showing the CSV, offer to save it as `.csv` file(s)
   (one per note type, e.g. `anki-basic.csv`, `anki-cloze.csv`) so the user can import
   directly. Write only if they agree.

---

## 2. Card-formulation principles

These are the heart of the skill. Apply them to *what* you make and *how* you word it.
(Distilled from Wozniak's "20 rules of formulating knowledge.")

1. **Atomic.** One card = one fact, relationship, or step. If the answer contains "and"
   joining independent facts, split it.
2. **Minimum information.** The answer is the shortest thing that proves recall — a word,
   phrase, or one tight sentence. Everything else goes in **Notes**.
3. **No open enumerations.** Never ask "list all N…". Convert a list into either (a)
   several cards each probing one item by its distinguishing cue, or (b) a Cloze
   sentence with one or two blanks, or (c) an overlapping-cloze set. Lists are the #1
   source of unlearnable cards.
4. **Unguessable & unambiguous.** The question must have essentially one correct answer
   and must not leak it (avoid yes/no, avoid giving the count, avoid grammatical tells).
   Prefer "Why…?", "How does X affect Y?", "What distinguishes X from Y?" over "What are
   the features of…?".
5. **Comprehend before encoding.** If you can't explain *why* a fact is true, the user
   probably can't either — clarify it with them first instead of carding rote words.
6. **Prerequisites get their own cards.** If a card relies on a term the user may not
   know, make a small card for that term too.
7. **Fight interference.** For confusable pairs (e.g. afferent vs efferent), make the
   contrast explicit ("…carries signals *toward* the CNS, not away") and add a
   discriminating hook in Notes.
8. **Wording is precise and stable.** Short, sharp, consistent phrasing. Background,
   caveats, and mnemonics live in Notes, never in the Question or cloze Text.
9. **Personalize in Notes.** Examples, images, mnemonics, and emotional hooks aid recall
   and belong in Notes.
10. **Prioritize ruthlessly.** Card high-value, generative ideas. Not every sentence
    deserves a card — say so when material is filler.
11. **No duplication.** Each fact gets exactly one card. Never make two cards that test
    the same thing — not within a note type, and not across them (e.g. a Basic card and a
    Cloze card asking for the same answer). Duplicates waste reviews and desync when one
    is edited. If a Basic card already covers a fact, the Cloze cards must test *different*
    facts. When a Basic and a Cloze would overlap, keep one and drop the other.

---

## 3. Choosing Basic vs Cloze

| Use **Basic** when… | Use **Cloze** when… |
|---|---|
| The idea is a natural question→answer (definition, cause, comparison). | The fact lives inside a sentence and context aids recall. |
| The answer is a derived/explained result, not a word lifted from a sentence. | You want to preserve original wording (quotes, formulas, terminology). |
| You're unsure (**default to Basic**). | 2–4 closely related facts fit one short sentence as separate clozes. |

**Never:** put `{{c1::…}}` syntax anywhere except a Cloze `Text` field; put a cloze in a
Basic Question/Answer; or hide clozes in Notes/Source/Tags.

Cloze tips: number related blanks `{{c1::…}}` `{{c2::…}}` to test them as separate cards
from one sentence. Add a disambiguating hint with `{{c1::answer::hint}}` when the blank
is otherwise not guessable. Keep cloze Text short — if it sprawls, switch to Basic.

---

## 4. Output format

When (and only when) generating, output the cards as CSV in fenced ` ```csv ` blocks,
**Basic and Cloze in separate blocks**, with no header row — the first line is data. At
import time the user selects the note type and maps the columns (and the Tags column) in
Anki's import dialog.

**Basic with source:**

```csv
"What does the CAP theorem say a distributed datastore can guarantee simultaneously?";"At most two of consistency, availability, and partition tolerance.";"C = every read sees the latest write. A = every request gets a non-error response. P = system keeps working despite dropped messages between nodes.";"<a href=\"\"https://en.wikipedia.org/wiki/CAP_theorem\"\">CAP theorem — Wikipedia</a>";"distributed-systems databases"
"In CAP, why do real distributed systems trade consistency against availability rather than against partition tolerance?";"Network partitions are unavoidable, so P is mandatory; the real choice is C vs A during a partition.";"";"<a href=\"\"https://en.wikipedia.org/wiki/CAP_theorem\"\">CAP theorem — Wikipedia</a>";"distributed-systems"
```

**Cloze with source** — note this tests the CP/AP classification, a *different* fact than
the Basic cards above; it does not restate what CAP guarantees (see principle 11):

```csv
"During a network partition, a datastore that stays available by serving possibly stale data is classified as {{c1::AP}}, while one that rejects requests to stay consistent is {{c2::CP}}.";"";"<a href=\"\"https://en.wikipedia.org/wiki/CAP_theorem\"\">CAP theorem — Wikipedia</a>";"distributed-systems"
```

If a note type yields no cards, write one plain-text line instead of an empty block,
e.g. *"No Cloze with source cards generated from this material."*

---

## 5. CSV mechanics (get these exactly right)

- **Separator:** semicolon `;`. **No header row** — the first line is data.
- **Quoting:** wrap **every** field in double quotes.
- **Escaping:** a literal `"` inside a field becomes `""`. (Inside a ` ```csv ` block in
  chat this looks like `\"\"` only because of display — in the written file it is `""`;
  when you Write the file, use plain `""`.)
- **Column order is positional** and must match the note type's field order so the user
  can map columns at import: Basic = `Question;Answer;Notes;Source;Tags`,
  Cloze = `Text;Notes;Source;Tags`, with Tags always last. If the user's note type orders
  fields differently, follow their order.
- HTML in fields renders only if the user enables "Allow HTML in fields" (or maps via an
  HTML-rendering field) at import — mention this when sources/notes use HTML.
- Fields may contain UTF-8, HTML, and line breaks; line breaks inside a quoted field are
  fine.

> Note on the example above: it is shown with escaped quotes for display. When you write
> the actual `.csv` file, internal quotes are doubled as `""` (standard CSV), e.g.
> `"<a href=""https://…"">CAP theorem</a>"`.

---

## 6. Field policies

**Question / Text** — concise, unambiguous, one atomic target (§2).

**Answer** — the minimal thing that proves recall. No "and"-bundles. Surplus → Notes.

**Notes** — optional; *never* required to grade the card. Examples, mnemonics,
disambiguation, derivations, related links, the "why". Empty = `""`.

**Source** — should not be empty.
- Real source, structured with light HTML:
  `Title<br><a href="URL">URL</a>` or `Section<br>Book Title<br>Author`.
- Synthesized/heavily-rephrased content with no external origin, *and the user agrees*:
  `Claude` (optionally `Claude Opus 4.8`).
- **Never invent realistic-looking fake sources.** If unknown, ask for a source or a
  policy before generating.

**Tags** — usually not empty; classify for retrieval.
- Space-separated, English. Hyphens inside a tag (`cognitive-bias`,
  `software-architecture`); `::` for hierarchy (`medicine::anatomy`, `english::idiom`).
- Prefer broad, durable categories (`biology`, `algorithms`, `psychology`) over one-off
  tags. 1–3 tags per card is typical. Ask for a scheme only if you genuinely can't infer
  one.

---

## 7. Pre-output checklist

Run this before emitting CSV:

1. **Atomicity & guessability** — each card is one idea; no card can be answered without
   knowing it; no leaked counts/answers; lists were split, not dumped.
2. **No duplication** — no two cards test the same fact, within or across note types
   (principle 11); Basic and Cloze cards cover *distinct* facts.
3. **Minimal answers** — answers are short; extra detail moved to Notes; Notes never hold
   grading-critical content.
4. **Structure** — Basic rows `Question;Answer;Notes;Source;Tags`; Cloze rows
   `Text;Notes;Source;Tags`; no header row; the two types in separate blocks; cloze
   syntax only in Cloze `Text`.
5. **CSV correctness** — semicolon-separated; every field quoted; internal `"` doubled as
   `""`; every row has exactly the right field count (5 Basic / 4 Cloze).
6. **Source & Tags** — Sources filled per the agreed policy, none fabricated; Tags
   present, broad, English, space-separated, hyphen/`::` only within a tag.
