# Bistro Bellini — La Maison 模板定制方案

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将 La Maison 法餐厅模板改造为 Bistro Bellini 正式意大利餐厅单页网站

**Architecture:** 单文件 HTML（`index.html`），所有修改集中在同一个文件。设计令牌通过 CSS 变量管理，JavaScript 仅用于导航、视差、滚动揭示和表单交互。按依赖顺序执行：先配色→字体→内容→图片→布局→交互。

**Tech Stack:** 纯 HTML/CSS/JS，零框架依赖。Google Fonts CDN 加载字体，Unsplash CDN 加载占位图片。

## Global Constraints

- 所有修改限于 `index.html` 单文件
- 配色严格遵循 DESIGN.md 中的 Olive & Stone 调色板
- 字体：Playfair Display（Hero）+ Cormorant Garamond（区段标题）+ Source Serif 4（正文）
- 品牌记忆点：「地中海的光线与食材」— 明调、自然、食材为本
- WCAG AA 对比度（正文 ≥ 4.5:1）
- 保持模板原有的响应式断点（767px）、动效系统和无障碍支持

---

## 文件结构

| 文件 | 职责 |
|------|------|
| `index.html` | 全部 HTML 结构、CSS 样式、JS 交互——所有修改在此文件 |

---

### Task 1: 替换 CSS 配色令牌

**Files:**
- Modify: `index.html` — 只修改 `:root` 中的 CSS 变量和少量硬编码颜色

**Interfaces:**
- Produces: 11 个 CSS 变量（`--olive` 系列替代 `--espresso` 系列，`--sage` 替代 `--amber`，`--stone` 替代 `--cream`，`--gold` 保持但调暖），后续所有任务依赖这些变量

- [ ] **Step 1: 定位 `:root` 变量块**

在 `index.html` 中找到第 27-50 行的 `:root` 块。当前内容：
```css
:root {
    --espresso: #2C1810;
    --espresso-90: rgba(44, 24, 16, 0.92);
    --espresso-60: rgba(44, 24, 16, 0.60);
    --espresso-40: rgba(44, 24, 16, 0.40);
    --cream: #F5F0E8;
    --cream-80: rgba(245, 240, 232, 0.80);
    --amber: #C4956A;
    --amber-15: rgba(196, 149, 106, 0.15);
    --gold: #B8935A;
    --gold-20: rgba(184, 147, 90, 0.20);
    --warm-gray: #3A322C;
    --light-warm: #E8DFD2;
    --border-warm: #D4C8B8;
    --white: #FFFDF9;
```

- [ ] **Step 2: 替换为 Olive & Stone 令牌**

用以下代码完整替换 `:root` 块：

```css
:root {
    --olive: #1D241A;
    --olive-90: rgba(29, 36, 26, 0.92);
    --olive-60: rgba(29, 36, 26, 0.60);
    --olive-40: rgba(29, 36, 26, 0.40);
    --stone: #F7F4EE;
    --stone-80: rgba(247, 244, 238, 0.80);
    --sage: #6B7D52;
    --sage-15: rgba(107, 125, 82, 0.15);
    --gold: #C4A44A;
    --gold-20: rgba(196, 164, 74, 0.20);
    --warm-charcoal: #3A3832;
    --light-warm: #E6E0D4;
    --border-warm: #D2CCC0;
    --white: #FFFDF7;
    --muted: #8C8878;
    --placeholder: #B5AFA0;

    --font-display: "Playfair Display", Georgia, "Times New Roman", serif;
    --font-section: "Cormorant Garamond", "Times New Roman", serif;
    --font-body: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;

    --max-text: 720px;
    --max-wide: 1040px;
    --nav-h: 64px;
}
```

- [ ] **Step 3: 全局搜索替换旧变量名**

将文件中所有旧变量名替换为新变量名（注意：CSS 类名、HTML 结构不改变）：
- `var(--espresso)` → `var(--olive)`
- `var(--espresso-90)` → `var(--olive-90)`
- `var(--espresso-60)` → `var(--olive-60)`
- `var(--espresso-40)` → `var(--olive-40)`
- `var(--cream)` → `var(--stone)`
- `var(--cream-80)` → `var(--stone-80)`
- `var(--amber)` → `var(--sage)`
- `var(--amber-15)` → `var(--sage-15)`
- `var(--gold)` → `var(--gold)` （名称不变，值已更新）
- `var(--gold-20)` → `var(--gold-20)` （名称不变，值已更新）
- `var(--warm-gray)` → `var(--warm-charcoal)`

运行：全文搜索替换。在编辑器中用正则 `--espresso\b` → `--olive`、`--cream\b` → `--stone`、`--amber\b` → `--sage`、`--warm-gray\b` → `--warm-charcoal`。`--gold` 和 `--gold-20` 名称不变，跳过。

- [ ] **Step 4: 替换硬编码颜色值为 CSS 变量**

搜索并替换文件中不在 CSS 变量中使用的硬编码颜色，统一替换为新增的令牌：
- `#8C8278`（菜单描述、地址等）→ `var(--muted)`
- `#B8AFA5`（placeholder 色）→ `var(--placeholder)`
- `#6E655C`（footer 链接）→ `var(--muted)`

同时更新 T3 中 Booking 区段的硬编码色值 `#8C8878` → `var(--muted)`。

- [ ] **Step 5: 更新 `::selection` 颜色**

找到 `::selection` 块，将 `background: var(--amber)` 改为 `background: var(--sage)`。

- [ ] **Step 6: 在浏览器中打开验证**

打开 `index.html`（双击或 `start index.html`），目视检查：
- Hero 背景是否变成深橄榄色
- Accent 元素（eyebrow、hover、链接）是否变成鼠尾草绿
- 背景是否是暖石灰白色
- Nav 滚动后的背景是否正常

- [ ] **Step 7: 提交**

```bash
git add index.html
git commit -m "feat: replace La Maison palette with Olive & Stone color tokens"
```

---

### Task 2: 替换字体

**Files:**
- Modify: `index.html` — Google Fonts `<link>` 标签和 `--font-body` 变量

**Interfaces:**
- Consumes: Task 1 的 CSS 变量结构
- Produces: `--font-body: "Source Serif 4", Georgia, "Times New Roman", serif;`

- [ ] **Step 1: 替换 Google Fonts 链接**

找到第 18 行的 `<link>` 标签：
```html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,600;1,400;1,600&family=Inter:opsz,wght@14..32,400;14..32,500&family=Playfair+Display:ital,wght@0,700;1,700&display=swap" rel="stylesheet">
```

替换为：
```html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,600;1,400;1,600&family=Playfair+Display:ital,wght@0,700;1,700&family=Source+Serif+4:opsz,wght@8..60,400;8..60,500&display=swap" rel="stylesheet">
```

关键变化：删除了 `Inter`，新增了 `Source+Serif+4:opsz,wght@8..60,400;8..60,500`。

- [ ] **Step 2: 更新 `--font-body` 变量**

在 `:root` 块中找到：
```css
--font-body: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
```

替换为：
```css
--font-body: "Source Serif 4", Georgia, "Times New Roman", serif;
```

- [ ] **Step 3: 添加正文字重（500 → bold-ish）**

在 `body` 样式中找到 `font-weight: 400;`（第 62 行），保持 400 不变。确认菜单菜名和按钮使用 `font-weight: 500;` 在 Source Serif 4 中可用（Source Serif 4 的 500 字重正常加载）。

- [ ] **Step 4: 浏览器验证**

打开 `index.html`，检查：
- 正文段落是否使用 Source Serif 4（衬线体，有温暖的印刷感）
- Hero 标题仍是 Playfair Display
- 区段标题仍是 Cormorant Garamond
- 字体加载是否正常（无 FOUT 或过长空白）

- [ ] **Step 5: 提交**

```bash
git add index.html
git commit -m "feat: replace Inter with Source Serif 4 — all-serif typography stack"
```

---

### Task 3: 替换页面内容为 Bellini 意大利餐厅

**Files:**
- Modify: `index.html` — `<title>`、`<meta>`、所有文本内容

**Interfaces:**
- Consumes: Task 2 的字体系统
- Produces: 完整的 Bellini 品牌文案（餐厅名、故事、菜单、地址等）

- [ ] **Step 1: 替换 `<title>` 和 `<meta>` 标签**

找到第 6-13 行：
```html
<title>La Maison — Seasonal French Cuisine</title>
<meta name="description" content="La Maison. Seasonal French cuisine in Portland since 2012. Chef Marie Laurent.">

<!-- Open Graph -->
<meta property="og:title" content="La Maison — Seasonal French Cuisine">
<meta property="og:description" content="Seasonal French cuisine in Portland since 2012. Reserve a table.">
<meta property="og:type" content="restaurant">
<meta property="og:image" content="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1200">
```

替换为：
```html
<title>Bistro Bellini — Handmade Italian Cuisine</title>
<meta name="description" content="Bistro Bellini. Handmade Italian cuisine featuring seasonal Mediterranean ingredients. Reserve a table.">

<!-- Open Graph -->
<meta property="og:title" content="Bistro Bellini — Handmade Italian Cuisine">
<meta property="og:description" content="Handmade Italian cuisine with seasonal Mediterranean ingredients. Reserve a table.">
<meta property="og:type" content="restaurant">
<meta property="og:image" content="https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=1200">
```

- [ ] **Step 2: 替换 Nav**

找到第 1002-1011 行：
```html
<nav class="nav" id="nav" role="navigation" aria-label="Main navigation">
  <a href="#" class="nav-logo">La Maison</a>
  <ul class="nav-links">
    <li><a href="#story">Story</a></li>
    <li><a href="#menu">Menu</a></li>
    <li><a href="#private">Private</a></li>
    <li><a href="#visit">Visit</a></li>
  </ul>
  <a href="#booking" class="nav-cta">Reserve</a>
</nav>
```

替换为：
```html
<nav class="nav" id="nav" role="navigation" aria-label="Main navigation">
  <a href="#" class="nav-logo">Bellini</a>
  <ul class="nav-links">
    <li><a href="#story">Story</a></li>
    <li><a href="#menu">Menu</a></li>
    <li><a href="#private">Private</a></li>
    <li><a href="#visit">Visit</a></li>
  </ul>
  <a href="#booking" class="nav-cta">Reserve</a>
</nav>
```

- [ ] **Step 3: 替换 Hero**

找到第 1014-1030 行，完整替换 Hero 区段：
```html
<!-- ====== HERO ====== -->
<section class="hero" id="hero">
  <div class="hero-bg" id="heroBg"></div>
  <div class="hero-overlay"></div>

  <div class="hero-content">
    <h1 class="hero-name">Bistro Bellini</h1>
    <p class="hero-tagline">
      Handmade Italian cuisine, seasonal Mediterranean ingredients.
      <span>Est. 2018</span>
    </p>
  </div>

  <div class="scroll-indicator" aria-hidden="true">
    <div class="scroll-line"></div>
    <span class="scroll-word">Scroll</span>
  </div>
</section>
```

- [ ] **Step 4: 替换 Story 区段**

找到第 1033-1066 行，完整替换：
```html
<!-- ====== STORY ====== -->
<section class="story" id="story">
  <div class="section-inner">
    <div class="story-grid reveal">
      <div class="story-text reveal-stagger">
        <p class="section-eyebrow">Our Story</p>
        <h2 class="section-title">A kitchen built on Sunday family dinners.</h2>
        <p>
          Chef Marco Bellini grew up in Bologna, where his nonna ruled the stove
          and the best conversations happened between courses of handmade tortellini.
          Bistro Bellini is his love letter to that table — seasonal, unhurried,
          made with hands that remember.
        </p>
        <p>
          Every dish starts with what the farmers bring in that morning. The menu
          changes when the weather does. What stays the same: the olive oil comes from
          a family grove in Tuscany, the wine list favors small Italian producers, and
          the pasta is rolled by hand twice a day.
        </p>
        <div class="chef-quote">
          <blockquote>
            "I'm not trying to reinvent Italian food. I'm trying to remind you why you fell in love with it."
          </blockquote>
          <cite>— Marco Bellini, Chef &amp; Owner</cite>
        </div>
      </div>
      <div class="story-photo reveal">
        <img
          src="https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=600&q=80"
          alt="Chef Marco Bellini in the kitchen, finishing a plate of handmade pasta"
          loading="lazy"
        >
      </div>
    </div>
  </div>
</section>
```

- [ ] **Step 5: 替换 Menu 区段**

找到第 1069-1172 行，完整替换菜单内容。保留 HTML 结构，只替换菜名、价格、描述：

```html
<!-- ====== MENU ====== -->
<section class="menu" id="menu">
  <div class="section-inner">
    <p class="section-eyebrow reveal">Current Menu</p>
    <h2 class="section-title reveal" style="margin-bottom:48px;">What's on the table this season.</h2>

    <div class="menu-grid reveal-stagger">

      <!-- Left column -->
      <div>
        <h3 class="menu-category-title">Antipasti</h3>

        <div class="dish">
          <span class="dish-name">Burrata &amp; Heirloom Tomato</span>
          <span class="dish-price">22</span>
          <span class="dish-desc">Basil oil, aged balsamic, sea salt, grilled focaccia</span>
        </div>

        <div class="dish">
          <span class="dish-name">Beef Carpaccio</span>
          <span class="dish-price">26</span>
          <span class="dish-desc">Shaved parmesan, wild arugula, truffle aioli, lemon</span>
        </div>

        <div class="dish">
          <span class="dish-name">Arancini di Riso</span>
          <span class="dish-price">18</span>
          <span class="dish-desc">Crispy saffron risotto balls, mozzarella center, arrabbiata dip</span>
        </div>

        <h3 class="menu-category-title" style="margin-top:32px;">Primi</h3>

        <div class="dish">
          <span class="dish-name">Tagliatelle al Tartufo</span>
          <span class="dish-price">34</span>
          <span class="dish-desc">Hand-rolled pasta, black truffle, parmigiano cream, chives</span>
        </div>

        <div class="dish">
          <span class="dish-name">Risotto ai Frutti di Mare</span>
          <span class="dish-price">38</span>
          <span class="dish-desc">Carnaroli rice, clams, mussels, prawns, saffron brodo</span>
        </div>

        <div class="dish">
          <span class="dish-name">Pappardelle al Cinghiale</span>
          <span class="dish-price">36</span>
          <span class="dish-desc">Wide ribbon pasta, slow-braised wild boar ragù, pecorino</span>
        </div>
      </div>

      <!-- Right column -->
      <div>
        <h3 class="menu-category-title">Secondi</h3>

        <div class="dish">
          <span class="dish-name">Branzino al Forno</span>
          <span class="dish-price">42</span>
          <span class="dish-desc">Whole roasted sea bass, capers, lemon, rosemary potatoes</span>
        </div>

        <div class="dish">
          <span class="dish-name">Osso Buco alla Milanese</span>
          <span class="dish-price">48</span>
          <span class="dish-desc">Braised veal shank, gremolata, saffron risotto</span>
        </div>

        <div class="dish">
          <span class="dish-name">Bistecca alla Fiorentina</span>
          <span class="dish-price">56</span>
          <span class="dish-desc">Grilled T-bone, rosemary-garlic oil, arugula &amp; parmesan</span>
        </div>

        <h3 class="menu-category-title" style="margin-top:32px;">Dolci</h3>

        <div class="dish">
          <span class="dish-name">Tiramisù Classico</span>
          <span class="dish-price">16</span>
          <span class="dish-desc">Mascarpone, espresso-soaked savoiardi, Valrhona cocoa</span>
        </div>

        <div class="dish">
          <span class="dish-name">Panna Cotta al Miele</span>
          <span class="dish-price">14</span>
          <span class="dish-desc">Vanilla bean, lavender honey, raspberry coulis, almond crumble</span>
        </div>

        <div class="dish">
          <span class="dish-name">Selezione di Formaggi</span>
          <span class="dish-price">22</span>
          <span class="dish-desc">Three Italian cheeses, mostarda di frutta, honeycomb, walnut bread</span>
        </div>
      </div>

      <!-- Full-width food photo interlude -->
      <div class="menu-photo-interlude reveal">
        <img
          src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=1200&q=80"
          alt="Plated dish at Bistro Bellini — warm candlelight across a white tablecloth"
          loading="lazy"
        >
      </div>
    </div>
  </div>
</section>
```

- [ ] **Step 6: 替换 Private Dining 区段**

找到第 1193-1229 行，替换：
```html
<!-- ====== PRIVATE DINING ====== -->
<section class="private" id="private">
  <div class="section-inner">
    <p class="section-eyebrow reveal">Private Dining</p>
    <h2 class="section-title reveal" style="margin-bottom:48px;">An evening that's entirely yours.</h2>

    <div class="private-grid reveal">
      <div class="private-photo reveal">
        <img
          src="https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800&q=80"
          alt="Long private dining table set for a celebration, candlelit"
          loading="lazy"
        >
      </div>
      <div class="private-text reveal-stagger">
        <p>
          The private room seats 8 to 24 guests, with a dedicated server and a custom menu built around
          what's best at the market that week. Birthdays, anniversaries, corporate dinners, or just a
          Tuesday that calls for something more.
        </p>
        <p>
          Chef Marco works with you directly to design the evening — three courses or six,
          wine pairings from the cellar, flowers on the table, and a kitchen that treats your
          guests like family.
        </p>
        <ul class="private-features">
          <li>Seats 8–24 guests</li>
          <li>Custom seasonal menu</li>
          <li>Wine &amp; cocktail pairings</li>
          <li>Dedicated service staff</li>
          <li>A/V for presentations</li>
          <li>Floral &amp; décor styling</li>
        </ul>
        <a href="#booking" class="private-cta">Inquire About Private Dining →</a>
      </div>
    </div>
  </div>
</section>
```

关键变化：`Chef Marie` → `Chef Marco`。

- [ ] **Step 7: 替换 Booking 区段**

找到第 1232-1315 行，替换地址和营业信息：
```html
<!-- ====== BOOKING ====== -->
<section class="booking" id="booking">
  <div class="section-inner">
    <p class="section-eyebrow reveal">Reservations</p>
    <h2 class="section-title reveal" style="margin-bottom:48px;">A table is waiting.</h2>

    <div class="booking-grid reveal">
      <div class="booking-info reveal-stagger">
        <div class="hours">
          <strong>Dinner</strong>
          Tuesday — Sunday<br>
          Bar opens 5:00pm<br>
          Kitchen 6:00pm — 10:00pm<br>

          <strong>Location</strong>
          <address>
            118 NW Everett Street<br>
            Portland, Oregon 97209
          </address>

          <strong>Phone</strong>
          (503) 555-0187<br><br>

          <em style="font-size:0.85rem;color:#8C8878;">Private dining available for parties of 8–24.</em>
        </div>
      </div>

      <div class="booking-form reveal">
        <!-- Netlify Forms — replace with Resy/OpenTable embed if restaurant has one -->
        <form name="reservation" method="POST" data-netlify="true" netlify-honeypot="bot-field">
          <input type="hidden" name="form-name" value="reservation">
          <p class="booking-embed-note" style="display:none;" aria-hidden="true">
            <input name="bot-field">
          </p>

          <div class="form-group">
            <label class="form-label" for="date">Date</label>
            <input class="form-input form-select" type="date" id="date" name="date" required>
          </div>

          <div class="form-row-split">
            <div class="form-group">
              <label class="form-label" for="time">Time</label>
              <select class="form-input form-select" id="time" name="time" required>
                <option value="">Select</option>
                <option>6:00 PM</option><option>6:30 PM</option><option>7:00 PM</option>
                <option>7:30 PM</option><option>8:00 PM</option><option>8:30 PM</option>
                <option>9:00 PM</option>
              </select>
            </div>
            <div class="form-group">
              <label class="form-label" for="guests">Guests</label>
              <select class="form-input form-select" id="guests" name="guests" required>
                <option value="">Select</option>
                <option>1</option><option>2</option><option>3</option><option>4</option>
                <option>5</option><option>6</option><option>7</option><option>8+</option>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="name">Name</label>
            <input class="form-input" type="text" id="name" name="name" placeholder="Your name" required autocomplete="name">
          </div>

          <div class="form-group">
            <label class="form-label" for="email">Email</label>
            <input class="form-input" type="email" id="email" name="email" placeholder="you@email.com" required autocomplete="email">
          </div>

          <div class="form-group">
            <label class="form-label" for="notes">Special requests (optional)</label>
            <input class="form-input" type="text" id="notes" name="notes" placeholder="Allergies, celebration, seating preference...">
          </div>

          <button class="btn-reserve" type="submit">Reserve a Table</button>
        </form>
        <p class="booking-embed-note">
          You'll receive a confirmation within 2 hours.<br>
          For same-day bookings, please call (503) 555-0187.
        </p>
      </div>
    </div>
  </div>
</section>
```

关键变化：地址 `214 NW Everett` → `118 NW Everett`，电话 `(503) 555-0142` → `(503) 555-0187`，营业时间 `Wednesday — Sunday` → `Tuesday — Sunday`。

- [ ] **Step 8: 替换 Footer**

找到第 1318-1330 行，替换：
```html
<!-- ====== FOOTER ====== -->
<footer class="footer" id="visit" role="contentinfo">
  <address>
    <strong>Bistro Bellini</strong>
    118 NW Everett Street, Portland, OR 97209<br>
    (503) 555-0187 · <a href="mailto:hello@bistrobellini.com" style="color:var(--sage);text-decoration:none;">hello@bistrobellini.com</a>
  </address>
  <div class="footer-links">
    <a href="#">Instagram</a>
    <a href="#">Privacy Policy</a>
    <a href="#">Accessibility</a>
    <a href="#">Press</a>
  </div>
</footer>
```

- [ ] **Step 9: 浏览器验证**

打开 `index.html`，通读整个页面：
- 餐厅名"Bistro Bellini"贯穿所有区段
- 菜单从法餐变为意大利菜
- 地址和联系方式已更新
- skip-link 的 href 仍指向 `#story`（有效）

- [ ] **Step 10: 提交**

```bash
git add index.html
git commit -m "feat: rewrite all content — French to Italian (Bellini brand, menu, story, contact)"
```

---

### Task 4: 替换图片为意大利风格

**Files:**
- Modify: `index.html` — 所有 `<img>` 标签的 `src` 和 `alt`，以及 `.hero-bg` 的背景图 URL

**Interfaces:**
- Consumes: Task 3 的内容结构
- Produces: 全部替换为意大利餐厅风格的 Unsplash 图片 URL

- [ ] **Step 1: 替换 Hero 背景图**

找到 `.hero-bg` 的 `background-image`（第 216 行）：
```css
background-image: url('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1800&q=80');
```

替换为（意大利餐厅内景，明亮自然光）：
```css
background-image: url('https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=1800&q=80');
```

- [ ] **Step 2: 替换 Story 照片**

找到 `.story-photo img`（第 1058-1062 行）：
```html
<img
  src="https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=600&q=80"
  alt="Chef Marco Bellini in the kitchen, finishing a plate of handmade pasta"
  loading="lazy"
>
```

`src` 改为（意大利厨房/厨师）：
```
https://images.unsplash.com/photo-1577219491135-ce391730fb2c?w=600&q=80
```

- [ ] **Step 3: 替换 Menu 区段照片**

找到 `.menu-photo-interlude img`（第 1164-1168 行）：
```html
<img
  src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=1200&q=80"
  alt="Plated dish at Bistro Bellini — warm candlelight across a white tablecloth"
  loading="lazy"
>
```

`src` 改为（手工意面特写）：
```
https://images.unsplash.com/photo-1645112411341-6c4fd023714a?w=1200&q=80
```

- [ ] **Step 4: 替换 Gallery 照片**

找到 `.gallery-strip` 中的 4 个 `<figure>`（第 1176-1189 行），全部替换 `src`：

```html
<section class="gallery reveal">
  <div class="gallery-strip">
    <figure>
      <img src="https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=600&q=80" alt="Fresh handmade pasta drying on a rack" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=600&q=80" alt="Olive oil drizzled over a finished dish" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80" alt="Plated Italian fine dining course" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=600&q=80" alt="Restaurant interior with warm candlelit tables" loading="lazy">
    </figure>
  </div>
</section>
```

- [ ] **Step 5: 替换 Private Dining 照片**

找到 `.private-photo img`（第 1199-1203 行）：
```html
<img
  src="https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800&q=80"
  alt="Long private dining table set for a celebration, candlelit"
  loading="lazy"
>
```

`src` 改为：
```
https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?w=800&q=80
```

- [ ] **Step 6: 更新 OG 图片**（如 Task 3 未完成）

确认 `<meta property="og:image">` 已指向新图片（Task 3 Step 1 已处理）。

- [ ] **Step 7: 浏览器验证**

打开 `index.html`，检查所有图片：
- 所有图片加载正常（无 404）
- 图片风格一致——明调、自然光、意大利感
- Hero 背景图与橄榄色叠加层搭配良好
- Gallery 四张图片各不相同

- [ ] **Step 8: 提交**

```bash
git add index.html
git commit -m "feat: replace all photos with Italian restaurant imagery"
```

---

### Task 5: Gallery 改为 Masonry 不等宽布局

**Files:**
- Modify: `index.html` — `.gallery-strip` 的 CSS 和 HTML

**Interfaces:**
- Consumes: Task 4 的图片 URL
- Produces: CSS columns-based masonry 替代 4 列正方形 grid

- [ ] **Step 1: 更新 Gallery CSS**

找到 `.gallery-strip` 的 CSS（第 571-600 行），完整替换：

```css
.gallery-strip {
  columns: 4;
  column-gap: 0;
  line-height: 0;
}

.gallery-strip figure {
  margin: 0;
  overflow: hidden;
  break-inside: avoid;
  margin-bottom: 0;
}

.gallery-strip img {
  width: 100%;
  height: auto;
  display: block;
  object-fit: cover;
  filter: saturate(0.7) brightness(0.7);
  transition: filter 0.6s ease, transform 0.6s ease;
}

.gallery-strip figure:hover img {
  filter: saturate(1) brightness(0.95);
  transform: scale(1.04);
}

@media (max-width: 767px) {
  .gallery-strip {
    columns: 2;
  }
}
```

关键变化：
- `grid-template-columns: repeat(4, 1fr)` → `columns: 4`
- `aspect-ratio: 1` 移除（图片保留原始比例）
- 新增 `break-inside: avoid` 防止图片跨列断裂
- `img` 的 `height` 从 `100%` 改为 `auto`
- 移除 `object-fit: cover` 上的 `width: 100%; height: 100%;`

- [ ] **Step 2: 更新 Gallery 的 HTML 以混合宽高比**

找到 `.gallery-strip`，增加为 8 张图片（Masonry 在不均等数量时效果最好）并混合横竖构图：

```html
<section class="gallery reveal">
  <div class="gallery-strip">
    <figure>
      <img src="https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=600&q=80" alt="Fresh handmade pasta drying on a rack" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=400&q=80" alt="Olive oil drizzled over a finished dish" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500&q=80" alt="Plated Italian fine dining course" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=400&q=80" alt="Restaurant interior with warm candlelit tables" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=600&q=80" alt="Elegant dining room with natural light" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1544025162-d76694265947?w=400&q=80" alt="Ribeye steak plated with herbs" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1498579150354-977475b7ea0b?w=500&q=80" alt="Wine being poured at a dinner table" loading="lazy">
    </figure>
    <figure>
      <img src="https://images.unsplash.com/photo-1481931098730-318b6f776db0?w=400&q=80" alt="Fresh cherry tomatoes and basil on a wooden board" loading="lazy">
    </figure>
  </div>
</section>
```

- [ ] **Step 3: 浏览器验证**

打开 `index.html`：
- Gallery 照片不再全是正方形——有些更高、有些更宽
- 图片之间无间隙（`column-gap: 0`）
- 桌面 4 列，移动端 2 列
- Hover 效果正常
- 无图片跨列断裂

- [ ] **Step 4: 提交**

```bash
git add index.html
git commit -m "feat: convert gallery to masonry layout — CSS columns, mixed aspect ratios"
```

---

### Task 6: 预订表单内联确认反馈

**Files:**
- Modify: `index.html` — 新增 CSS（确认卡片样式）和 JS（表单提交处理）

**Interfaces:**
- Consumes: Task 3 的预订表单 HTML 结构
- Produces: 表单提交 → spinner → 内联确认卡片（替换表单）

- [ ] **Step 1: 新增确认状态 CSS**

在 `</style>` 之前（约第 993 行）新增以下 CSS：

```css
/* ================================================================
   BOOKING CONFIRMATION — Inline card replaces form on submit
   ================================================================ */

.booking-confirmation {
  display: none;
  background: var(--white);
  padding: 48px 36px;
  border-radius: 2px;
  border: 1px solid var(--border-warm);
  text-align: center;
}

.booking-confirmation.visible {
  display: block;
  animation: confirmReveal 0.6s 0.1s cubic-bezier(0.25, 0.46, 0.45, 0.94) both;
}

.booking-confirmation-icon {
  font-size: 2.5rem;
  margin-bottom: 16px;
  display: block;
  color: var(--sage);
}

.booking-confirmation h3 {
  font-family: var(--section);
  font-weight: 600;
  font-size: 1.3rem;
  color: var(--olive);
  margin-bottom: 12px;
}

.booking-confirmation p {
  font-size: 0.9rem;
  line-height: 1.7;
  color: var(--warm-charcoal);
  max-width: 360px;
  margin: 0 auto 8px;
}

.booking-confirmation .confirm-name {
  font-weight: 500;
  color: var(--olive);
}

.booking-confirmation .confirm-detail {
  font-size: 0.78rem;
  color: #8C8878;
  margin-top: 14px;
  line-height: 1.6;
}

/* Spinner — subtle pulse, not a generic loading wheel */
.booking-spinner {
  display: none;
  text-align: center;
  padding: 48px 36px;
}

.booking-spinner.visible {
  display: block;
}

.booking-spinner-dot {
  display: inline-block;
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--sage);
  margin: 0 4px;
  animation: dotPulse 1.2s ease-in-out infinite;
}

.booking-spinner-dot:nth-child(2) { animation-delay: 0.2s; }
.booking-spinner-dot:nth-child(3) { animation-delay: 0.4s; }

@keyframes dotPulse {
  0%, 80%, 100% { opacity: 0.3; transform: scale(0.8); }
  40% { opacity: 1; transform: scale(1); }
}

@keyframes confirmReveal {
  from { opacity: 0; transform: translateY(12px); }
  to { opacity: 1; transform: translateY(0); }
}

/* Hide form when submitting or confirmed */
.booking-form.submitted form {
  display: none;
}
```

- [ ] **Step 2: 在预订表单 HTML 后添加确认卡片和 spinner**

在 `</form>` 之后、`<p class="booking-embed-note">` 之前（约第 1307 行），新增：

```html
        <!-- Inline confirmation — hidden until form submit -->
        <div class="booking-confirmation" id="bookingConfirm" aria-live="polite">
          <span class="booking-confirmation-icon" aria-hidden="true">&#10003;</span>
          <h3>Thank you, <span class="confirm-name" id="confirmName">friend</span>.</h3>
          <p>Your reservation request has been received. We'll confirm within 2 hours.</p>
          <p class="confirm-detail">
            For same-day bookings or parties larger than 8,<br>
            please call us at (503) 555-0187.
          </p>
        </div>

        <!-- Spinner — shown briefly during submission -->
        <div class="booking-spinner" id="bookingSpinner" aria-hidden="true">
          <span class="booking-spinner-dot"></span>
          <span class="booking-spinner-dot"></span>
          <span class="booking-spinner-dot"></span>
        </div>
```

- [ ] **Step 3: 新增表单提交 JS**

在 `</script>` 之前（约第 1443 行），新增：

```javascript
/* ===========================================================
   BOOKING FORM — Inline confirmation on submit
   =========================================================== */

(function() {
  var form = document.querySelector('.booking-form form');
  if (!form) return;

  var formContainer = document.querySelector('.booking-form');
  var confirmation = document.getElementById('bookingConfirm');
  var spinner = document.getElementById('bookingSpinner');
  var confirmName = document.getElementById('confirmName');
  var nameInput = document.getElementById('name');

  form.addEventListener('submit', function(e) {
    e.preventDefault();

    // Show spinner, hide form
    formContainer.classList.add('submitted');
    spinner.classList.add('visible');

    // Read the name the user typed (fallback: "friend")
    var guestName = (nameInput && nameInput.value.trim()) || 'friend';
    confirmName.textContent = guestName;

    // Simulate network delay, then show confirmation
    // Replace this setTimeout with a real fetch() when a backend exists
    setTimeout(function() {
      spinner.classList.remove('visible');
      confirmation.classList.add('visible');
    }, 1200);
  });
})();
```

- [ ] **Step 4: 浏览器端到端验证**

打开 `index.html`：
1. 滚动到预订区段
2. 输入姓名 "Marco"，填写日期、时间、人数、邮箱
3. 点击 "Reserve a Table"
4. 观察：表单消失 → 3 个 pulse dot（1.2 秒）→ 确认卡片滑入显示 "Thank you, Marco."
5. 刷新页面，确认表单重置

- [ ] **Step 5: 提交**

```bash
git add index.html
git commit -m "feat: add inline booking confirmation with spinner and personalized message"
```

---

## 完成验证

全部任务完成后，运行最终检查：

```bash
# 打开页面
start index.html

# 检查清单：
# - [ ] 配色：橄榄深底 + 鼠尾草绿 accent + 石灰白背景
# - [ ] 字体：Playfair Display (hero) + Cormorant Garamond (titles) + Source Serif 4 (body)
# - [ ] 内容：全部意大利化 — 餐厅名、菜单、故事、地址
# - [ ] 图片：明调地中海风，自然光
# - [ ] Gallery：Masonry 不等宽，混合横竖构图
# - [ ] 预订：表单提交 → spinner → 确认卡片
# - [ ] 移动端：767px 断点正常，Gallery 2 列
# - [ ] 无障碍：skip-link、focus-visible、reduced-motion 均正常
# - [ ] 控制台无 JS 错误
```
