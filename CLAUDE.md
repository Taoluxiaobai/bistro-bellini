# Bistro Bellini

## Design System
Always read DESIGN.md before making any visual or UI decisions.
All font choices, colors, spacing, and aesthetic direction are defined there.
Do not deviate without explicit user approval.
In QA mode, flag any code that doesn't match DESIGN.md.

## Template Customization — New Client Fast Path

This project is a template. New clients are created by running `./new-client.sh`
and then customizing the template. **When the user invokes a new client, do NOT
run /plan-design-review or /design-consultation interactively.** Those are heavy
workflows for greenfield projects. For template customization, accept the client's
parameters inline and apply them directly.

### New client trigger
When the user says something like "新客户 [name]" or references `new-client.sh`,
they want the fast path. Ask ONLY for the parameters you genuinely need. Infer
everything else from the template.

### Required parameters (ask if missing)
- **Name**: 餐厅名称 (e.g., "Trattoria Milano")
- **Type**: 菜系/风格 (e.g., "正式意大利", "休闲法餐", "地中海融合")
- **Color direction**: 配色方向 (e.g., "陶土+酒红", "海军蓝+金", "橄榄+石灰")
- **Photo style**: 照片风格 (e.g., "明调自然光", "暗调戏剧光", "混合场景")

### Optional parameters (infer from type if not specified)
- **Font preference**: 默认全衬线（Playfair + Cormorant + Source Serif 4）
- **Gallery layout**: 默认 Masonry columns
- **Booking form**: 默认保留内联确认

### Fast path workflow (no AskUserQuestion unless blocked)
1. Read `DESIGN.md` and `index.html` to understand current template state
2. Translate the client's brief into 6 specific design decisions (color tokens, font stack, photo style, gallery layout, content direction)
3. Present all decisions as one compact confirmation: "我会做这些改动：[summary]。确认吗？"
4. Apply all changes directly (same 6-task structure: colors → fonts → content → images → gallery → booking)
5. Run `/qa` (quick tier)
6. Commit

### Color tokens reference
The template uses these CSS variables. For each new client, replace the hex values:
```
--olive (dark base), --stone (light bg), --sage (accent), --gold (secondary),
--warm-charcoal (body text), --light-warm (light-on-dark), --border-warm,
--white (card bg), --muted (description text), --placeholder
```

### Font tokens reference
```
--font-display (hero), --font-section (titles), --font-body (paragraphs)
```
Google Fonts link must match. Default: Playfair Display + Cormorant Garamond + Source Serif 4.

### Content replacement checklist
- `<title>` and OG meta tags
- Nav logo text
- Hero h1 + tagline + year
- Story: chef name, bio, quote, alt text
- Menu: all dishes, categories, prices
- Private dining: chef name reference
- Booking: address, phone, email, hours
- Footer: restaurant name, address, email
- All alt text on images
- CSS banner comments (DESIGN TOKENS block)

### What NOT to change
- HTML structure (sections, div hierarchy)
- CSS layout (grid, flex, spacing)
- JS logic (nav scroll, reveal animations, booking form)
- Accessibility features (skip-link, focus-visible, reduced-motion, aria labels)

## Skill routing

When the user's request matches an available skill, invoke it via the Skill tool. When in doubt, invoke the skill.

Key routing rules:
- New client from template → apply inline (fast path above), skip /plan-design-review and /design-consultation
- Product ideas/brainstorming → invoke /office-hours
- Strategy/scope → invoke /plan-ceo-review
- Architecture → invoke /plan-eng-review
- Design system/plan review → invoke /design-consultation or /plan-design-review (greenfield only, not template clients)
- Full review pipeline → invoke /autoplan
- Bugs/errors → invoke /investigate
- QA/testing site behavior → invoke /qa or /qa-only
- Code review/diff check → invoke /review
- Visual polish → invoke /design-review
- Ship/deploy/PR → invoke /ship or /land-and-deploy
- Save progress → invoke /context-save
- Resume context → invoke /context-restore
- Author a backlog-ready spec/issue → invoke /spec
